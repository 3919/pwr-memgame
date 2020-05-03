--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:22:04 05/03/2020
-- Design Name:   
-- Module Name:   /home/windspring/Xilinx/14.7/ISE_DS/controller_ps2/vga_tb.vhd
-- Project Name:  controller_ps2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: vga_driver
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
 
ENTITY vga_tb IS
END vga_tb;
 
ARCHITECTURE behavior OF vga_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT vga_driver
    PORT(
         clk : IN  std_logic;
         lock_in : IN  std_logic;
         lock_out : OUT  std_logic;
         mem_address : OUT  std_logic_vector(15 downto 0);
         mem_datain : IN  std_logic_vector(7 downto 0);
         vga_data : OUT  std_logic_vector(7 downto 0);
         vga_we : OUT  std_logic;
         vga_busy : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal lock_in : std_logic := '0';
   signal mem_datain : std_logic_vector(7 downto 0) := (others => '0');
   signal vga_busy : std_logic := '0';

 	--Outputs
   signal lock_out : std_logic;
   signal mem_address : std_logic_vector(15 downto 0);
   signal vga_data : std_logic_vector(7 downto 0);
   signal vga_we : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: vga_driver PORT MAP (
          clk => clk,
          lock_in => lock_in,
          lock_out => lock_out,
          mem_address => mem_address,
          mem_datain => mem_datain,
          vga_data => vga_data,
          vga_we => vga_we,
          vga_busy => vga_busy
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	lock_in <= '0';
   -- Stimulus process
   stim_proc: process
   begin		
      
      wait for 100 ns;
   end process;

END;
