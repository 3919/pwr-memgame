----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:05:25 04/05/2020 
-- Design Name: 
-- Module Name:    counter - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    Port (  clk : in  STD_LOGIC;
				reset : in  STD_LOGIC;
            ticks : out  STD_LOGIC_VECTOR (7 downto 0));
end counter;

architecture Behavioral of counter is
 constant COUNT_MAX : integer := 2**ticks'LENGTH;
 signal i_ticks : integer range 0 to COUNT_MAX-1 := 0;
begin
	
	ticks <= std_logic_vector(to_unsigned(i_ticks, ticks'LENGTH));
	counter: process(clk)
		begin
			if rising_edge(clk) then
				if reset = '0' then
					i_ticks <= (i_ticks + 1) mod COUNT_MAX;
				else
					i_ticks <= 0;
				end if;
			end if;
		end process counter;
end Behavioral;