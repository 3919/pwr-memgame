library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

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

architecture Behavioral of object_generator is
	type state_type is (WAITING, GENERATING, READY);
	signal state : state_type;
	signal current_address : std_logic_vector(o_mem_address'range);
	signal random_value : unsigned(i_random'range);
begin

	GenerateProc: process(clock, i_reset)
	begin
		if i_reset = '1' then
			state <= WAITING;
			current_address <= (others => '0');
			random_value <= (unsigned(i_random) mod 10) + 48;
		elsif rising_edge(clock) then
			case state is
				when WAITING =>
					state <= GENERATING;
					o_ready <= '1';
				when GENERATING =>
					if current_address /= i_object_count then
						o_ready <= '0';
						o_mem_we <= '1';
						o_mem_address <= current_address;
						o_mem_dataout <= std_logic_vector(random_value);
						
						random_value <= (unsigned(i_random) mod 10) + 48;
						current_address <= std_logic_vector(unsigned(current_address) + 1);
					else
						state <= READY;
					end if;
				when READY =>
					o_ready <= '1';
			end case;
		end if;
	end process GenerateProc;

end Behavioral;

