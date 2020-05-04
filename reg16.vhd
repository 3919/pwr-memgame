----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:28:09 04/05/2020 
-- Design Name: 
-- Module Name:    reg16 - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg16 is
    Port ( data_in : in  STD_LOGIC_VECTOR (15 downto 0);
           data_out : out  STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC;
           en : in  STD_LOGIC);
end reg16;

architecture Behavioral of reg16 is
	signal data_out_s : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
begin
	data_out <= data_out_s;
	process(clk)
	begin
	  if rising_edge(clk) then
		 if en = '1' then  -- synchronous enable
			data_out_s <= data_in;
		 end if;
	  end if;
end process;

end Behavioral;

