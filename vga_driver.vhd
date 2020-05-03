----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:52:15 04/19/2020 
-- Design Name: 
-- Module Name:    vga_driver - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

entity vga_driver is
    Port ( 	clk         : in     STD_LOGIC;
				lock_in     : in     STD_LOGIC;
				lock_out    : out    STD_LOGIC;
				mem_address : out    std_logic_vector(15 downto 0);
				mem_datain  : in     std_logic_vector(7 downto 0);
				vga_data    : out    std_logic_vector(7 downto 0);
				vga_we		: out 	std_logic;
				vga_busy		: in 	   std_logic);
end vga_driver;

architecture Behavioral of vga_driver is
	 component counter
		Port( clk   : in  std_logic;
				reset : in  std_logic;
				ticks : out  std_logic_vector(15 downto 0));
    end component;
			 
	-- counter signals
	signal reset : STD_LOGIC := '0';
	signal ticks : STD_LOGIC_VECTOR(15 downto 0);
	
begin
	ticker : counter PORT MAP (
      clk =>clk,
      reset => reset,
      ticks => ticks
   );
	
	vga_data <= mem_datain when vga_busy = '0';
	mem_address <= ticks;
	
	load: process(ticks, vga_busy, lock_in)
	begin
		if lock_in = '0' and vga_busy = '0' and ticks < X"3c0"
		then
			reset <= '0';
			vga_we <= '1';
		else
			vga_we <= '0';
			reset <= '1';
		end if;
	end process;

lock_out <= '1' when lock_in ='0' else '0'; 
end Behavioral;