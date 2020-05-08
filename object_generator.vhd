library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity object_generator is
  port (
    clock          : in   std_logic;
    i_object_count : in   STD_LOGIC_VECTOR (15 downto 0);
    i_reset        : in   STD_LOGIC;
    o_ready        : out  std_logic;
    i_random       : in   STD_LOGIC_VECTOR (7 downto 0);
    o_mem_we       : out  STD_LOGIC;
    o_mem_address  : out  STD_LOGIC_VECTOR (15 downto 0);
    i_mem_datain   : in   STD_LOGIC_VECTOR (7 downto 0);
    o_mem_dataout  : out  STD_LOGIC_VECTOR (7 downto 0)
  );
end object_generator;

larchitecture Behavioral of object_generator is
  type state_type is (RESET, GENERATING_PREPARE, GENERATING_SHUFFLE, GENERATING_SWAP_RD1, GENERATING_SWAP_RD2, GENERATING_SWAP_WR, READY);
  signal state : state_type;
  signal current_address : std_logic_vector(o_mem_address'range);
  signal swap_buffer_current : std_logic_vector(i_mem_datain'range);
  signal swap_buffer_random : std_logic_vector(i_mem_datain'range);
  signal random_address : unsigned(o_mem_address'range);

  constant MAX_OBJ : integer := 960;
begin

  GenerateProc: process(clock, i_reset)
    variable counter : unsigned(o_mem_dataout'range);
  begin
    if i_reset = '1' then
      state <= RESET;

    elsif rising_edge(clock) then
      case state is
        when RESET =>
          state <= GENERATING_PREPARE;
          current_address <= (others => '0');
          random_address <= X"00" & (unsigned(i_random) mod MAX_OBJ);
          counter := X"48";
          o_ready <= '0';

        when GENERATING_PREPARE =>
          if current_address /= i_object_count then
            o_mem_we <= '1';
            o_mem_address <= current_address;
            o_mem_dataout <= std_logic_vector(counter);
            current_address <= std_logic_vector(unsigned(current_address) + 1);
            counter := counter + 1;
          else
            o_mem_we <= '0';
            current_address <= std_logic_vector(to_unsigned(1,current_address'length));
            state <= GENERATING_SHUFFLE;
          end if;

        when GENERATING_SHUFFLE =>
          o_mem_we <= '0';
          if current_address /= i_object_count then
            -- Prepare for next cycle
            o_mem_address <= current_address;
            state <= GENERATING_SWAP_RD1;
          else
            state <= READY;
          end if;

        when GENERATING_SWAP_RD1 =>
          -- Read from current address. Prepared in previous state.
          swap_buffer_current <= i_mem_datain;

          -- Prepare for next cycle (2nd read, random address smaller than current)
          -- Random address is prepared in previous state with iterative method.
          random_address <= X"00" & (unsigned(i_random) mod MAX_OBJ);
          o_mem_we <= '0';
          o_mem_address <= std_logic_vector(random_address);

          state <= GENERATING_SWAP_RD2;

        when GENERATING_SWAP_RD2 =>
          swap_buffer_random <= i_mem_datain;

          -- Prepare for next cycle (write at random address, cached value from current address)
          o_mem_we <= '1';
          o_mem_dataout <= swap_buffer_current;

          state <= GENERATING_SWAP_WR;

        when GENERATING_SWAP_WR =>
          -- Prepare for next cycle (write at current address, cached value from random address)
          o_mem_we <= '1';
          o_mem_address <= current_address;
          o_mem_dataout <= swap_buffer_random;

          current_address <= std_logic_vector(unsigned(current_address) + 1);

          state <= GENERATING_SHUFFLE;

        when READY =>
          o_ready <= '1';

      end case;
    end if;
  end process GenerateProc;

end Behavioral;

