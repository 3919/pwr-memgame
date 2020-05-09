library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga_driver is
    Port ( 	clk         : in     STD_LOGIC;
				enable      : in     STD_LOGIC;
				mode	      : in     STD_LOGIC_VECTOR(1 downto 0);
				work	      : out    STD_LOGIC;
				mem_address : out    std_logic_vector(15 downto 0);
				mem_datain  : in     std_logic_vector(7 downto 0);
				mouse_pos	: in     std_logic_vector(15 downto 0);
				vga_data    : out    std_logic_vector(7 downto 0);
				vga_we		: out 	std_logic;
				vga_reset	: out 	std_logic;
				vga_busy		: in 	   std_logic);
end vga_driver;

	
architecture Behavioral of vga_driver is

 constant display_size : integer := 48*20;
 signal ticks : integer range 0 to 1024 := 0;
 
 type char_table is array(natural range <>) of std_logic_vector(7 downto 0);
 constant message_lost : char_table(7 downto 0):= (X"59",X"6f",X"75",X"20",X"6c",X"6f",X"73",X"74"); -- You lost
 constant message_win : char_table(6 downto 0):= (X"59",X"6f",X"75",X"20",X"77",X"69",X"6e");  -- You win
 
 constant black_tail : std_logic_vector(7 downto 0) := X"10";
 constant cursor : std_logic_vector(7 downto 0) := X"1e";
 constant space : std_logic_vector(7 downto 0) := X"20";
 
 -- VGA signals
 signal vga_we_s		: std_logic :='0';
 signal vga_reset_s	: std_logic :='0';
 
begin
	mem_address <= std_logic_vector(to_unsigned(ticks, mem_address'LENGTH));
	vga_we <= vga_we_s;
	vga_reset <= vga_reset_s;
	
	vga_reset_s <= '0' when enable ='1' else '1';
	vga_we_s <= not vga_we_s when enable ='1' else '0';
	load_img: process(clk, ticks, enable, mode, mem_datain)
	begin
		if rising_edge(clk) and enable = '1'
		then
			if mode = "00" 
			then -- start mode, when everything is read as it is
				if ticks = to_integer(unsigned(mouse_pos))
				then
					vga_data <= cursor;
				else
					vga_data <= mem_datain;
				end if;
			elsif mode = "01" 
			then -- hidden mode, each number is converted to black tail
				if ticks = to_integer(unsigned(mouse_pos)) 
				then
					vga_data <= cursor;
				else
					if mem_datain /= space 
					then
						vga_data <= black_tail; 
					else
						vga_data <= space;
					end if;
				end if;
			elsif mode = "10" 
			then -- user lost mode, print communicate that user lost
					if ticks < message_lost'LENGTH 
					then
						vga_data <= message_lost(ticks);
					else
						vga_data <= space;
					end if;
			else -- user win mode, print communicate that user win
				if ticks < message_win'LENGTH 
				then
						vga_data <= message_win(ticks);
					else
						vga_data <= space;
					end if;
			end if;
		end if;
	end process;
	
	load_addr: process(clk, ticks, vga_busy, enable)
	begin
		if rising_edge(clk) and enable = '1' and vga_busy = '0' 
		then
			if ticks < display_size
			then
				ticks <= (ticks + 1);
				work <= '1';	
			else
				ticks <= 0;
				work <= '0';				
			end if;
		end if;
	end process;

end Behavioral;