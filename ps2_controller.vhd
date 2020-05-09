library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity ps2_controller is
 Port (clk : in std_logic;
		B1_status : in  STD_LOGIC_VECTOR (7 downto 0); -- button status, signes etc. return by mouse
		B2_X : in  STD_LOGIC_VECTOR (7 downto 0); -- x offset returned by mouse
		B3_Y : in  STD_LOGIC_VECTOR (7 downto 0); -- y offset returned by mouse
		dataready : in STD_LOGIC;  -- signal send by mouse when some new data is ready
		mouse_irq : out STD_LOGIC; -- inform logic that user clicked button
		logic_irq : in STD_LOGIC; -- get information if data was read
		mouse_x : out STD_LOGIC_VECTOR (15 downto 0);
		mouse_y : out STD_LOGIC_VECTOR (15 downto 0));
end ps2_controller;

architecture Behavioral of ps2_controller is
	constant max_x_pos : integer := 4800;
	constant max_y_pos : integer := 2000;
	-- general signals 
	signal mouse_irq_s : STD_LOGIC := '0';
	signal mouse_x_s : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
	signal mouse_y_s : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');

	-- reg with x position signals
	signal mouse_raw_x : STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
	-- reg with y position signals
	signal mouse_raw_y : STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
  
begin

	mouse_irq <= mouse_irq_s;

calc_pos:process(clk, mouse_raw_x, mouse_raw_y, B1_status)
begin
	if rising_edge(clk)
	then
		if B1_status(4) = '0' then
		  mouse_x_s <= mouse_x_s + mouse_raw_x;
		else
		  mouse_x_s <= (mouse_x_s - mouse_raw_x);
		end if;

		if B1_status(5) = '0' then
		  mouse_y_s <= (mouse_y_s + mouse_raw_y);
		else
		  mouse_y_s <= (mouse_y_s - mouse_raw_y);
		end if;

		if mouse_x_s >= max_x_pos then
			mouse_x_s <= X"12c0";
		end if;

		if mouse_x_s < 0 then
			mouse_x_s <= X"0000";
		end if;

		if mouse_y_s >= max_y_pos then
			mouse_y_s <= X"07d0";
		end if;

		if mouse_y_s < 0 then
			mouse_y_s <= X"0000";
		end if;
	end if;
end process;

assign_pos:process(clk, mouse_x_s, mouse_y_s, logic_irq)
begin
	if rising_edge(clk)
	then
		if logic_irq ='0' then
			if mouse_x_s < 0  then
				mouse_x <= X"0000";
			elsif mouse_x_s >= max_x_pos then
				mouse_x <= X"12c0";
			else
				mouse_x <= mouse_x_s;
			end if;

			if mouse_y_s < 0 then
				mouse_y <= X"0000";
			elsif mouse_y_s >= max_y_pos then
				mouse_y <= X"07d0";
			else
				mouse_y <= mouse_y_s;
			end if;
		end if;
	end if;
end process;

mouse_raw_x <= x"00"&B2_X when dataready = '1' else x"0000";
mouse_raw_y <= x"00"&B3_Y when dataready = '1' else x"0000";

mouse_irq_s <= '1' when B1_status(0) ='1' or logic_irq = '1' else '0';

end Behavioral;
