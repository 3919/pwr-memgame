LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ps2_controller_tb IS
END ps2_controller_tb;
 
ARCHITECTURE behavior OF ps2_controller_tb IS
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ps2_controller
    PORT(
         clk : IN  std_logic;
         B1_status : IN  std_logic_vector(7 downto 0);
         B2_X : IN  std_logic_vector(7 downto 0);
         B3_Y : IN  std_logic_vector(7 downto 0);
         dataready : IN  std_logic;
         mouse_irq : OUT  std_logic;
			logic_irq : IN  std_logic;
         x_cur_pos : OUT  std_logic_vector(15 downto 0);
         y_cur_pos : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal clk : std_logic := '0';
   signal B1_status : std_logic_vector(7 downto 0) := (others => '0');
   signal B2_X : std_logic_vector(7 downto 0) := (others => '0');
   signal B3_Y : std_logic_vector(7 downto 0) := (others => '0');
   signal dataready : std_logic := '0';

 	--Outputs
   signal mouse_irq : std_logic;
	signal logic_irq : std_logic;
   signal x_cur_pos : std_logic_vector(15 downto 0);
   signal y_cur_pos : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: ps2_controller PORT MAP(
		 clk => clk,
		 B1_status => B1_status,
		 B2_X => B2_X,
		 B3_Y => B3_Y,
		 dataready => dataready,
		 mouse_irq => mouse_irq,
		 logic_irq => logic_irq,
		 x_cur_pos => x_cur_pos,
		 y_cur_pos => y_cur_pos
	  );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	logic_irq <= '0';
	
   -- Stimulus process
   stim_proc: process
		type typeByteArray is array ( NATURAL range<> )of STD_LOGIC_VECTOR( 7 downto 0 );
		variable x_pos_test : typeByteArray( 0 to 3 ):= ( X"01", X"02", X"03", X"04" );
		variable y_pos_test : typeByteArray( 0 to 3 ):= ( X"01", X"02", X"03", X"04" );
   begin
		for i in x_pos_test'RANGE loop
			B2_x <= x_pos_test(i);
			B3_y <= y_pos_test(i);
			B1_status <= not B1_status;
			dataready <= '1';
			wait for clk_period*2;
			dataready <= '0';
			wait for clk_period*2;
			
		end loop;
   end process;
END;
