library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity ps2_controller is
    Port (clk : in  STD_LOGIC;
		  B1_status : in  STD_LOGIC_VECTOR (7 downto 0);
		  B2_X : in  STD_LOGIC_VECTOR (7 downto 0);
		  B3_Y : in  STD_LOGIC_VECTOR (7 downto 0);
		  dataready : in STD_LOGIC;
		  mouse_irq : out STD_LOGIC;
		  logic_irq : in STD_LOGIC;
		  x_cur_pos : out STD_LOGIC_VECTOR (15 downto 0);
		  y_cur_pos : out STD_LOGIC_VECTOR (15 downto 0));
end ps2_controller;

architecture Behavioral of ps2_controller is
	 
	-- general signals 
	signal clk_s : STD_LOGIC;
	signal mouse_irq_s : STD_LOGIC := '0';
	signal cur_pos_x_s : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
	signal cur_pos_y_s : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');

	-- register signals
	signal en_reg : STD_LOGIC;
	-- reg with x position signals
	signal data_in_reg_x : STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
	-- reg with y position signals
	signal data_in_reg_y : STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
  
begin
	clk_s <= clk;
	mouse_irq <= mouse_irq_s;

calc_pos:process(data_in_reg_x, data_in_reg_y)
begin 
		cur_pos_x_s <= cur_pos_x_s;
		cur_pos_y_s <= cur_pos_y_s;
		
		if B1_status(4) = '0' and cur_pos_x_s < 480 then
		  cur_pos_x_s <= cur_pos_x_s + data_in_reg_x;
		elsif cur_pos_x_s > 0 then
		  cur_pos_x_s <= cur_pos_x_s - data_in_reg_x;
		end if;
	
		if B1_status(5) = '0' and cur_pos_y_s < 200 then
		  cur_pos_y_s <= cur_pos_y_s + data_in_reg_y;
		elsif cur_pos_y_s > 0 then
		  cur_pos_y_s <= cur_pos_y_s - data_in_reg_y;
		end if;
		
end process;

assign_pos:process(cur_pos_x_s, cur_pos_y_s)
begin
	if logic_irq ='0' then
		if cur_pos_x_s < 0  then
			x_cur_pos <= X"0000";
		elsif cur_pos_x_s >= 480 then
			x_cur_pos <= X"01e0";
		else
			x_cur_pos <= cur_pos_x_s;
		end if;
		
		if cur_pos_y_s < 0 then
			y_cur_pos <= X"0000";
		elsif cur_pos_y_s >= 200 then
			y_cur_pos <= X"01e0";
		else
			y_cur_pos <= cur_pos_y_s;
		end if;
	end if;
end process;

data_in_reg_x <= x"00"&B2_X when dataready = '1';
data_in_reg_y <= x"00"&B3_Y when dataready = '1';

mouse_irq_s <= '1' when B1_status(0) ='1' and logic_irq ='1' else '0';
end Behavioral;
