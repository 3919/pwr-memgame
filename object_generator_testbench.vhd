LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY object_generator_tb IS
END object_generator_tb;

ARCHITECTURE behavior OF object_generator_tb IS 

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT object_generator
    PORT(
         clock : IN  std_logic;
         i_object_count : IN  std_logic_vector(15 downto 0);
         i_reset : IN  std_logic;
         o_ready : OUT  std_logic;
         i_random : IN  std_logic_vector(7 downto 0);
         o_mem_we : OUT  std_logic;
         o_mem_address : OUT  std_logic_vector(15 downto 0);
         i_mem_datain : IN  std_logic_vector(7 downto 0);
         o_mem_dataout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;


   --Inputs
   signal clock : std_logic := '0';
   signal i_object_count : std_logic_vector(15 downto 0) := (others => '0');
   signal i_reset : std_logic := '0';
   signal i_random : std_logic_vector(7 downto 0) := (others => '0');
   signal i_mem_datain : std_logic_vector(7 downto 0) := (others => '0');

  --Outputs
   signal o_ready : std_logic;
   signal o_mem_we : std_logic;
   signal o_mem_address : std_logic_vector(15 downto 0);
   signal o_mem_dataout : std_logic_vector(7 downto 0);

  type memory_type is array (0 to ((2**o_mem_address'length)-1)) of std_logic_vector(i_mem_datain'range);
   signal memory : memory_type;
   signal read_address : std_logic_vector(o_mem_address'range);

   -- Clock period definitions
   constant clock_period : time := 10 ns;

BEGIN

  -- Instantiate the Unit Under Test (UUT)
   uut: object_generator PORT MAP (
          clock => clock,
          i_object_count => i_object_count,
          i_reset => i_reset,
          o_ready => o_ready,
          i_random => i_random,
          o_mem_we => o_mem_we,
          o_mem_address => o_mem_address,
          i_mem_datain => i_mem_datain,
          o_mem_dataout => o_mem_dataout
        );

   -- Clock process definitions
   clock_process :process
   begin
    clock <= '0';
    wait for clock_period/2;
    clock <= '1';
    wait for clock_period/2;
   end process;

  AddressProc: process(clock) is
  begin
    if rising_edge(clock) then
      if o_mem_we = '1' then
        memory(to_integer(unsigned(o_mem_address))) <= o_mem_dataout;
      end if;
        read_address <= o_mem_address;
    end if;
  end process AddressProc;

  i_mem_datain <= memory(to_integer(unsigned(read_address)));


   -- Stimulus process
   stim_proc: process
   begin
    wait for 25ns;

    i_reset <= '1';
    --i_mem_datain <= std_logic_vector(to_unsigned(5, i_mem_datain'length));
    --o_mem_dataout <= std_logic_vector(to_unsigned(9, i_object_count'length));
      wait for clock_period;
    i_object_count <= std_logic_vector(to_unsigned(8, i_object_count'length));
      i_random <= "01100011";
    wait for clock_period;
    i_reset <= '0';
    wait for clock_period;
    i_random <= "01010110";
    wait for clock_period;
    i_random <= "10110110";
    wait for clock_period;
    i_random <= "10101101";
    wait for clock_period;
    i_random <= "10100011";
    wait for clock_period;
    i_random <= "00100110";
    wait for clock_period;
    i_random <= "10101010";
    wait for clock_period;
    i_random <= "01010110";
    wait for clock_period;
    i_random <= "10110110";
    wait for clock_period;
    i_random <= "10101101";
    wait for clock_period;
    i_random <= "10100011";
    wait for clock_period;
    i_random <= "00100110";
    wait for clock_period;
    i_random <= "10101010";
    wait for clock_period;
    i_random <= "01010110";
    wait for clock_period;
    i_random <= "10110110";
    wait for clock_period;
    i_random <= "10101101";
    wait for clock_period;
    i_random <= "10100011";
    wait for clock_period;
    i_random <= "00100110";
    wait for clock_period;
    i_random <= "10101010";
    wait for clock_period;
    i_random <= "01010110";
    wait for clock_period;
    i_random <= "10110110";
    wait for clock_period;
    i_random <= "10101101";
    wait for clock_period;
    i_random <= "10100011";
    wait for clock_period;
    i_random <= "00100110";
    wait for clock_period;
    i_random <= "10101010";

    wait;
   end process;

END;
