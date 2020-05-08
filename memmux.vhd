library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity memmux is
    port (
      clk         : in  std_logic;
      A_we        : in  std_logic;
      A_address   : in  std_logic_vector (15 downto 0);
      A_datain    : in  std_logic_vector (7 downto 0);
      B_we        : in  std_logic;
      B_address   : in  std_logic_vector (15 downto 0);
      B_datain    : in  std_logic_vector (7 downto 0);
      C_we        : in  std_logic;
      C_address   : in  std_logic_vector (15 downto 0);
      C_datain    : in  std_logic_vector (7 downto 0);
      SEL         : in  std_logic_vector (1 downto 0);
      OUT_we      : out std_logic;
      OUT_address : out std_logic_vector (15 downto 0);
      OUT_datain  : out std_logic_vector (7 downto 0)
    );
end memmux;

architecture Behavioral of memmux is

begin

  process(clk)
  begin
    if rising_edge(clk) then
      case SEL is
        when "00" => 
          OUT_we <= A_we;
          OUT_address <= A_address;
          OUT_datain <= A_datain;
        when "01" => 
          OUT_we <= B_we;
          OUT_address <= B_address;
          OUT_datain <= B_datain;
        when "10" =>
          OUT_we <= C_we;
          OUT_address <= C_address;
          OUT_datain <= C_datain;
        when others =>
          OUT_we <= C_we;
          OUT_address <= C_address;
          OUT_datain <= C_datain;
      end case;
    end if;
  end process;

end Behavioral;

