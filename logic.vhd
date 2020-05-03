library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity logic is
  port (
    objgen_we      : in  std_logic;
    objgen_address : in  std_logic_vector (15 downto 0);
    objgen_datain  : out std_logic_vector (7 downto 0);
    objgen_dataout : in  std_logic_vector (7 downto 0);
    clk            : in  std_logic;
    ps2_irq        : in  std_logic;
    ps2_x          : in  std_logic_vector (15 downto 0);
    ps2_y          : in  std_logic_vector (15 downto 0);
    vga_address    : in  std_logic_vector (15 downto 0);
    vga_datain     : out std_logic_vector (7 downto 0);
    vga_enable     : out std_logic;
    vga_work       : in  std_logic
  );
end logic;

architecture Behavioral of logic is
  component memmux
  port (
    clk         : in  std_logic;
    A_we        : in  std_logic;
    A_address   : in  std_logic_vector (15 downto 0);
    A_datain    : in  std_logic_vector (7 downto 0);
    B_we        : in  std_logic;
    B_address   : in  std_logic_vector (15 downto 0);
    B_datain    : in  std_logic_vector (7 downto 0);
    S           : in  bit;
    OUT_we      : out std_logic;
    OUT_address : out std_logic_vector (15 downto 0);
    OUT_datain  : out std_logic_vector (7 downto 0)
  );
  end component;

  component ram16
  port (
    clock   : in  std_logic;
    we      : in  std_logic;
    address : in  std_logic_vector(15 downto 0);
    datain  : in  std_logic_vector(7 downto 0);
    dataout : out std_logic_vector(7 downto 0)
  );
  end component;

  component object_generator
  port (
    clock          : in   std_logic;
    i_object_count : in   std_logic_vector (15 downto 0);
    i_reset        : in   std_logic;
    o_ready        : out  std_logic;
    i_random       : in   std_logic_vector (7 downto 0);
    o_mem_we       : out  std_logic;
    o_mem_address  : out  std_logic_vector (15 downto 0);
    i_mem_datain   : in   std_logic_vector (7 downto 0);
    o_mem_dataout  : out  std_logic_vector (7 downto 0)
  );
  end component;

  -- vga module cannot write
  signal vga_we      : std_logic := '0';
  signal vga_dataout : std_logic_vector (7 downto 0) := "00000000";

  constant MEM_VGA_OWN    : bit := '1';
  constant MEM_OBJGEN_OWN : bit := '0';
  signal mem_select       : bit := MEM_OBJGEN_OWN;

  signal mem_we      : std_logic;
  signal mem_address : std_logic_vector(15 downto 0);
  signal mem_datain  : std_logic_vector(7 downto 0);
  signal mem_dataout : std_logic_vector(7 downto 0);

  -- Object generator signals
  signal sog_object_count : std_logic_vector (15 downto 0);
  signal sog_reset        : std_logic;
  signal sog_ready        : std_logic;
  signal sog_random       : std_logic_vector (7 downto 0);
  signal sog_mem_we       : std_logic;
  signal sog_mem_address  : std_logic_vector (15 downto 0);
  signal sog_mem_datain   : std_logic_vector (7 downto 0);
  signal sog_mem_dataout  : std_logic_vector (7 downto 0);

  type state_type is (RESET, BOOTSTRAP, IDLE, IRQ, DRAW, GAME_LOST, GAME_WIN);
  signal state : state_type := RESET;

  constant MAX_OBJECT_COUNT : unsigned(sog_object_count'range) := X"0006";
begin

  mem: ram16 port map
  (
     clock   => clk,
     we      => mem_we,
     address => mem_address,
     datain  => mem_datain,
     dataout => mem_dataout
  );

  objgen: object_generator port map
  (
     clock          => clk,
     i_object_count => sog_object_count,
     i_reset        => sog_reset,
     o_ready        => sog_ready,
     i_random       => sog_random,
     o_mem_we       => sog_mem_we,
     o_mem_address  => sog_mem_address,
     i_mem_datain   => sog_mem_datain,
     o_mem_dataout  => sog_mem_dataout
  );

  mm: memmux port map
  (
     clk         => clk,
     A_we        => objgen_we,
     A_address   => objgen_address,
     A_datain    => objgen_dataout, -- objgen_dataout is this modules datain
     B_we        => vga_we,
     B_address   => vga_address,
     B_datain    => vga_dataout,    -- vga_dataout is this modules datain
     S           => mem_select,
     OUT_we      => mem_we,
     OUT_address => mem_address,
     OUT_datain  => mem_datain
  );

  process (clk) is
  begin
    if rising_edge(clk) then
      case state is
      when RESET =>
        sog_reset <= '1';
        vga_enable <= '0';
        state <= BOOTSTRAP;
      when BOOTSTRAP =>
        if sog_ready = '1' then
          sog_reset <= '1';
          state <= IDLE;
        else
          sog_reset <= '0';
          sog_object_count <= std_logic_vector(MAX_OBJECT_COUNT);
        end if;
      when IDLE =>
        if ps2_irq = '1' then
          state <= IRQ;
        end if;
      when IRQ =>
      -- TODO(Pawel)
      when DRAW =>
      -- TODO(Pawel)
      when GAME_LOST =>
      -- TODO(all)
      when GAME_WIN =>
      -- TODO(all)
      end case;
    end if;
  end process;

end Behavioral;

