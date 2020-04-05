LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY lcg_8_testbench IS
END lcg_8_testbench;
 
ARCHITECTURE behavior OF lcg_8_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
	constant CLOCK_FREQ_HZ : integer := 10;
	constant CLOCK_PERIOD  : time    := 1000 ms / CLOCK_FREQ_HZ;
	constant LCG_WIDTH     : integer := 8;
    
	 COMPONENT lcg
	 GENERIC (SEED_WIDTH : integer);
    PORT(
         i_seed     : IN   std_logic_vector(LCG_WIDTH-1 downto 0);
         i_generate : IN   std_logic;
         i_reset    : IN   std_logic;
         o_random   : OUT  std_logic_vector(LCG_WIDTH-1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal i_seed     : std_logic_vector(LCG_WIDTH-1 downto 0) := ("10110111");
   signal i_generate : std_logic := '0';
   signal i_reset    : std_logic := '0';

 	--Outputs
   signal o_random : std_logic_vector(LCG_WIDTH-1 downto 0);
 
 
	signal CLK : std_logic := '1';
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	
   uut: lcg 
	GENERIC MAP (SEED_WIDTH => LCG_WIDTH)
	PORT MAP (
          i_seed => i_seed,
          i_generate => i_generate,
          i_reset => i_reset,
          o_random => o_random
        );

	CLK <= not CLK after CLOCK_PERIOD / 2;

   -- Stimulus process
   stim_proc: process
   begin		
		wait until rising_edge(CLK);
		wait until rising_edge(CLK);
		
		i_reset <= '1';
		
		wait until rising_edge(CLK);
		
		i_reset <= '0';
		wait until rising_edge(CLK);
		i_generate <= '1';
		wait for CLOCK_PERIOD*3;
		i_generate <= '0';
		wait for CLOCK_PERIOD*3;
		i_generate <= '1';
		wait for CLOCK_PERIOD*3;
		i_generate <= '0';
		wait for CLOCK_PERIOD*3;
		i_generate <= '1';
		wait for CLOCK_PERIOD*3;
		i_generate <= '0';
		wait for CLOCK_PERIOD*3;
		i_generate <= '1';
      
		wait;
   end process;

END;
