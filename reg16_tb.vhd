--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:26:09 04/08/2020
-- Design Name:   
-- Module Name:   /home/windspring/Xilinx/14.7/ISE_DS/controller_ps2/reg16_tb.vhd
-- Project Name:  controller_ps2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: reg16
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY reg16_tb IS
END reg16_tb;
 
ARCHITECTURE behavior OF reg16_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT reg16
    PORT(
         data_in : IN  std_logic_vector(15 downto 0);
         data_out : OUT  std_logic_vector(15 downto 0);
         clk : IN  std_logic;
         en : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal data_in : std_logic_vector(15 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal en : std_logic := '0';

 	--Outputs
   signal data_out : std_logic_vector(15 downto 0);
	
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: reg16 PORT MAP (
          data_in => data_in,
          data_out => data_out,
          clk => clk,
          en => en
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
 	en <= not en after clk_period*3;
  
	-- Stimulus process
   stim_proc: process
		type typeByteArray is array ( NATURAL range<> )of STD_LOGIC_VECTOR( 7 downto 0 );
		variable data_test : typeByteArray( 0 to 7 ):= ( X"01", X"02", X"03", X"04",X"06", X"06", X"07", X"08" );
	begin
      for i in data_test'RANGE loop
			data_in <= X"00"&data_test(i);
			wait for clk_period;
		end loop;
   end process;

END;
