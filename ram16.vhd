library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity ram16 is
  port (
    clock   : in  std_logic;
    we      : in  std_logic;
    address : in  std_logic_vector(15 downto 0);
    datain  : in  std_logic_vector(7 downto 0);
    dataout : out std_logic_vector(7 downto 0)
  );
end entity ram16;

architecture RTL of ram16 is

   type memory_type is array (0 to ((2**address'length)-1)) of std_logic_vector(datain'range);
   signal memory : memory_type;
   signal read_address : std_logic_vector(address'range);

begin

  AddressProc: process(clock) is
  begin
    if rising_edge(clock) then
      if we = '1' then
        memory(to_integer(unsigned(address))) <= datain;
      end if;
      read_address <= address;
    end if;
  end process AddressProc;

  dataout <= memory(to_integer(unsigned(read_address)));

end architecture RTL;
