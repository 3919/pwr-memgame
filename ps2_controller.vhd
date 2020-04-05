----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:48:41 04/05/2020 
-- Design Name: 
-- Module Name:    ps2_controller - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ps2_controller is
    Port ( clk : in  STD_LOGIC;
           B1_status : in  STD_LOGIC_VECTOR (7 downto 0);
           B2_X : in  STD_LOGIC_VECTOR (7 downto 0);
           B3_Y : in  STD_LOGIC_VECTOR (7 downto 0);
			  dataready : in STD_LOGIC;
			  mouse_status : out STD_LOGIC_VECTOR (7 downto 0);
			  x_cur_pos : out STD_LOGIC_VECTOR (15 downto 0);
			  y_cur_pos : out STD_LOGIC_VECTOR (15 downto 0);
			  pos_ready : out STD_LOGIC);
			  
end ps2_controller;

architecture Behavioral of ps2_controller is

	component reg16
		Port ( data_in : in  STD_LOGIC_VECTOR (15 downto 0);
				 data_out : out  STD_LOGIC_VECTOR (15 downto 0);
				 clk : in  STD_LOGIC;
				 en : in  STD_LOGIC);
	end component;
	signal data_in_reg_x : STD_LOGIC_VECTOR (15 downto 0);
   signal data_out_reg_x : STD_LOGIC_VECTOR (15 downto 0);
   
	
	signal data_in_reg_y : STD_LOGIC_VECTOR (15 downto 0);
   signal data_out_reg_y : STD_LOGIC_VECTOR (15 downto 0);
	
	signal clk_reg : STD_LOGIC;
	signal en_reg : STD_LOGIC;
	signal processing_done : STD_LOGIC := '0';
	
	signal cur_pos_x_s : STD_LOGIC_VECTOR (15 downto 0);
	signal cur_pos_y_s : STD_LOGIC_VECTOR (15 downto 0);
   
begin
	reg_x_pos : reg16 PORT MAP(
		data_in => data_in_reg_x,
		data_out => data_out_reg_x,
		clk => clk_reg,
		en => en_reg
	);
	
	reg_y_pos : reg16 PORT MAP(
		data_in => data_in_reg_y,
		data_out => data_out_reg_y,
		clk => clk_reg,
		en => en_reg
	);
	
	clk_reg <= clk;
	mouse_status <= B1_status;
	x_cur_pos <= cur_pos_x_s;
	y_cur_pos <= cur_pos_y_s;
	pos_ready <= processing_done;
	
calc_pos:process(clk, dataready)
begin 
	if rising_edge(clk) and dataready = '1' then
		processing_done <= '0';
		cur_pos_x_s <= cur_pos_x_s + data_in_reg_x;
		cur_pos_y_s <= cur_pos_y_s + data_in_reg_y;
	else
		processing_done <= '1';
	end if;
end process;

load_reg: process(clk, processing_done)
begin
	if rising_edge(clk) and processing_done = '1' then
		en_reg <= '1';
		data_in_reg_x <= x"00"&B2_X;
		data_in_reg_y <= x"00"&B3_Y;
	else
		en_reg <= '0';
	end if;
end process;

end Behavioral;

