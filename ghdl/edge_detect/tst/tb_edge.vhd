library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_edge is
end entity tb_edge;

architecture behavioral of tb_edge is
	signal rst  : std_logic;
	signal clk  : std_logic;
	signal i    : std_logic;
	signal o1   : std_logic;
	signal o2   : std_logic;
begin
	dut1 : entity work.edge(mealy)
	port map (
		rst, clk, i, o1
	);
	
	dut2 : entity work.edge(moore)
	port map (
		rst, clk, i, o2
	);
	
	tst : process
	begin
		-- reset (async.)
		rst <= '1';
		clk <= '0';
		i <= '0';

		wait for 10 ns;

		rst <= '0';

		-- free cycle

		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';

		wait for 5 ns;

		-- test 1: normal pulse

		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';
		i <= '1';

		wait for 5 ns;
		
		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';
		i <= '0';

		wait for 5 ns;
		
		-- free cycle

		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';

		wait for 5 ns;
		
		-- test 2: close pulse

		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';

		wait for 4 ns;

		i <= '1';

		wait for 1 ns;
		
		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';
		i <= '0';

		wait for 5 ns;
		
		-- free cycle

		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';

		wait for 5 ns;

		-- test 3: no free cycle 

		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';
		i <= '1';

		wait for 5 ns;
		
		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';
		i <= '0';

		wait for 5 ns;

		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';
		i <= '1';

		wait for 5 ns;
		
		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';
		i <= '0';

		wait for 5 ns;
		
		-- free cycle

		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';

		wait for 5 ns;
		
		-- test 4: long pulse 

		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';
		i <= '1';

		wait for 5 ns;
		
		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';

		wait for 5 ns;

		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';

		wait for 5 ns;
		
		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';
		i <= '0';

		wait for 5 ns;

		-- free cycle

		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';

		wait for 5 ns;

		-- test 5: short pulse 

		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';
		i <= '1';

		wait for 3 ns;
		
		i <= '0';
		
		wait for 2 ns;
		
		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';

		wait for 5 ns;

		-- free cycle

		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';

		wait for 5 ns;
	
		-- test 5: aligned pulse 

		clk <= '1';
		i <= '1';
		
		wait for 5 ns;

		clk <= '0';
		i <= '0';

		wait for 5 ns;
			
		clk <= '1';
		
		wait for 5 ns;

		clk <= '0';

		wait for 5 ns;


		wait;
	end process tst;

end architecture behavioral;
