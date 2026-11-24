library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;

entity tb_sqrt_approx is
end entity tb_sqrt_approx;

architecture behavioral of tb_sqrt_approx is
	signal clk   : std_logic;
	signal rst   : std_logic;
	signal start : std_logic;
	signal a     : std_logic_vector(7 downto 0);
	signal b     : std_logic_vector(7 downto 0);
	signal ready : std_logic;
	signal res   : std_logic_vector(8 downto 0);
begin
	dut : entity work.sqrt_approx(fsmd)
	port map (
		clk, rst, start, a , b, ready, res
	);

	stim : process
		file vectors : text open read_mode is "vectors.txt";
		variable l : line;
		variable ia, ib, ires : integer;
	begin
		rst <= '1';
		clk <= '0';
		start <= '0';
		
		wait for 5 ns;

		while not endfile(vectors) loop
			-- read vectors
			readline(vectors, l);
			read(l, ia);
			read(l, ib);
			read(l, ires);

			clk <= '1';

			wait for 5 ns;

			clk <= '0';
			rst <= '0';
			a <= std_logic_vector(to_signed(ia, 8));
			b <= std_logic_vector(to_signed(ib, 8));

			wait for 5 ns;

			clk <= '1';

			wait for 5 ns;

			clk <= '0';
			start <= '1';

			wait for 5 ns;

			-- S1
			clk <= '1';
		
			wait for 5 ns;
			
			clk <= '0';
			start <= '0';
			
			wait for 5 ns;
			
			-- S2
			clk <= '1';
			wait for 5 ns;
			clk <= '0';
			wait for 5 ns;
			
			-- S3
			clk <= '1';
			wait for 5 ns;
			clk <= '0';
			wait for 5 ns;
			
			-- S4
			clk <= '1';
			wait for 5 ns;
			clk <= '0';
			wait for 5 ns;
			
			-- S5
			clk <= '1';
			wait for 5 ns;
			clk <= '0';
			wait for 5 ns;
			
			-- result
			clk <= '1';

			assert ready = '1'
			    report "DEFCON 1: COMPUTATIONAL READINESS FAILURE. THE RESULT HAS FAILED TO MATERIALIZE. INITIATE EMERGENCY ABORT."
			    severity failure;
			
			assert res = std_logic_vector(to_signed(ires, 9))
			    report "STRATEGIC COMPUTATION FAILURE: OUTPUT DEVIATES FROM VERIFIED INTELLIGENCE. DISPATCHING COURT-MARTIAL. ALL UNITS, STAND BY FOR NUCLEAR OPTION."
			    severity failure;

			wait for 5 ns;

			clk <= '0';
			
			wait for 5 ns;

		end loop;

		wait;
	end process;
end architecture behavioral;
