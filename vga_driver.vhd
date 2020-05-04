library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga_driver is
    Port ( 	clk         : in     STD_LOGIC;
				enable      : in     STD_LOGIC;
				work	      : out    STD_LOGIC;
				mem_address : out    std_logic_vector(15 downto 0);
				mem_datain  : in     std_logic_vector(7 downto 0);
				ps2_pos		: in     std_logic_vector(15 downto 0);
				vga_data    : out    std_logic_vector(7 downto 0);
				vga_we		: out 	std_logic;
				vga_busy		: in 	   std_logic);
end vga_driver;

architecture Behavioral of vga_driver is
 constant COUNT_MAX : integer := 2**mem_address'LENGTH;
 signal ticks : integer range 0 to COUNT_MAX-1 := 0;
begin
	vga_data <= X"1e" when ticks = to_integer(unsigned(ps2_pos)) else mem_datain;
	mem_address <= std_logic_vector(to_unsigned(ticks, mem_address'LENGTH));
	
	load: process(clk, vga_busy, enable)
	begin
		vga_we <= '0';
		if rising_edge(clk) and enable = '1' and vga_busy = '0'
		then
			ticks <= (ticks + 1) mod COUNT_MAX;
			vga_we <= '1';
		elsif ticks >= 960
		then	
			ticks <= 0;
		end if;
	end process;

work <= '1' when (enable ='1' and ticks < 960) else '0'; 
end Behavioral;