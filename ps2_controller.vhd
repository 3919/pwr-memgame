library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity ps2_controller is
    Port ( clk : in  STD_LOGIC;
           B1_status : in  STD_LOGIC_VECTOR (7 downto 0);
           B2_X : in  STD_LOGIC_VECTOR (7 downto 0);
           B3_Y : in  STD_LOGIC_VECTOR (7 downto 0);
			  dataready : in STD_LOGIC;
			  mouse_irq : inout STD_LOGIC;
			  x_cur_pos : out STD_LOGIC_VECTOR (15 downto 0);
			  y_cur_pos : out STD_LOGIC_VECTOR (15 downto 0);
			  pos_ready : out STD_LOGIC);
end ps2_controller;

architecture Behavioral of ps2_controller is
	component reg16
		Port ( data_in : in  STD_LOGIC_VECTOR (15 downto 0);
				 data_out : out  STD_LOGIC_VECTOR (15 downto 0);
				 clk : in  STD_LOGIC;
				 en : in  STD_LOGIC);
	end component;
	
	component counter
		Port( clk   : in  std_logic;
				reset : in  std_logic;
				ticks : out  std_logic_vector(15 downto 0));
    end component;
	 
	-- general signals 
	signal clk_s : STD_LOGIC;
	signal mouse_irq_s : STD_LOGIC := '0';
	signal processing_done : STD_LOGIC;	
	signal cur_pos_x_s : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
	signal cur_pos_y_s : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');

	-- register signals
	signal en_reg : STD_LOGIC;
	-- reg with x position signals
	signal data_in_reg_x : STD_LOGIC_VECTOR (15 downto 0);
   signal data_out_reg_x : STD_LOGIC_VECTOR (15 downto 0);
	-- reg with y position signals
	signal data_in_reg_y : STD_LOGIC_VECTOR (15 downto 0);
   signal data_out_reg_y : STD_LOGIC_VECTOR (15 downto 0);
	-- counter signals
	signal reset : STD_LOGIC := '0';
	signal ticks : STD_LOGIC_VECTOR(15 downto 0);
   
begin
	reg_x_pos : reg16 PORT MAP(
		data_in => data_in_reg_x,
		data_out => data_out_reg_x,
		clk => clk_s,
		en => en_reg
	);
	
	reg_y_pos : reg16 PORT MAP(
		data_in => data_in_reg_y,
		data_out => data_out_reg_y,
		clk => clk_s,
		en => en_reg
	);
	
	ticker : counter PORT MAP (
      clk =>clk_s,
      reset => reset,
      ticks => ticks
   );
	
	clk_s <= clk;
	mouse_irq <= mouse_irq_s;
	x_cur_pos <= cur_pos_x_s;
	y_cur_pos <= cur_pos_y_s;
	pos_ready <= processing_done;
	
calc_pos:process(clk, processing_done, B1_status)
begin 
		cur_pos_x_s <= cur_pos_x_s;
		cur_pos_y_s <= cur_pos_y_s;
		reset <= '0';
	if rising_edge(clk) and processing_done = '1' then
		reset <= '1';
		if B1_status(4) = '0' then
		  cur_pos_x_s <= cur_pos_x_s + data_out_reg_x;
		else
		  cur_pos_x_s <= cur_pos_x_s - data_out_reg_x;
		end if;
		
		if B1_status(5) = '0' then
		  cur_pos_y_s <= cur_pos_y_s + data_out_reg_y;
		else
		  cur_pos_y_s <= cur_pos_y_s - data_out_reg_y;
		end if;
		
	end if;
end process;

count_when_proc:process(ticks)
begin
	processing_done <= '0';
	if ticks >= x"5" and dataready = '1' then
		processing_done <= '1';
	end if;
end process;

data_in_reg_x <= x"00"&B2_X;
data_in_reg_y <= x"00"&B3_Y;
en_reg <= '1' when processing_done = '1' else '0';
mouse_irq_s <= '1' when B1_status(0) ='1' or B1_status(1) = '1' or B1_status(2)='1';
end Behavioral;