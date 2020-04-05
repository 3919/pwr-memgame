library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.NUMERIC_STD.to_unsigned;

entity lcg is
	generic(SEED_WIDTH: integer := 8);
    Port ( i_seed     : in   STD_LOGIC_VECTOR (SEED_WIDTH-1 downto 0);
           i_generate : in   STD_LOGIC;
			  i_reset    : in   STD_LOGIC;
           o_random   : out  STD_LOGIC_VECTOR (SEED_WIDTH-1 downto 0)
	);
end lcg;

architecture Behavioral of lcg is
	signal rc_a     : STD_LOGIC_VECTOR (SEED_WIDTH-1 downto 0);
	signal rc_c     : STD_LOGIC_VECTOR (SEED_WIDTH*2-1 downto 0);
	signal r_seed   : STD_LOGIC_VECTOR (SEED_WIDTH-1 downto 0);
	signal r_mul_res : STD_LOGIC_VECTOR (SEED_WIDTH*2-1 downto 0);
	signal r_add_res : STD_LOGIC_VECTOR (SEED_WIDTH*2-1 downto 0);
begin
	process(i_reset, i_generate) is
	begin
		if i_reset = '1' then
			r_seed <= i_seed;
			rc_a <= std_logic_vector(to_unsigned(65539, rc_a'length));
			rc_c <= std_logic_vector(to_unsigned(1235, rc_c'length));
			r_mul_res <= (others => '0');
			r_add_res <= (others => '0');
		elsif rising_edge(i_generate) then
			r_mul_res <= unsigned(r_seed) * unsigned(rc_a);
			r_add_res <= unsigned(r_seed) * unsigned(rc_a) + unsigned(rc_c);
			r_seed <= r_add_res(7 downto 0);
		end if;
	end process;
	
	o_random <= r_seed;

end Behavioral;

