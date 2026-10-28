library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

entity tb_fsm is
end tb_fsm;

architecture behav of tb_fsm is
	signal p   : std_logic;
	signal clk : std_logic;
	signal rst : std_logic;
	
	signal r1  : std_logic;
	signal r2  : std_logic;
begin
	dut1 : entity work.fsm_1proc
	port map (p, r1, clk, rst);
	
	dut2 : entity work.fsm_2proc
	port map (p, r2, clk, rst);

	process
		file vectors : text open read_mode is "vectors.txt";
		variable l : line;
		variable vp, vrst, vr1, vr2 : std_logic;
	begin
		while not endfile(vectors) loop
			readline(vectors, l);

			read(l, vp);
			read(l, vrst);
			read(l, vr1);
			read(l, vr2);

			clk <= '0';
			p <= vp;
			rst <= vrst;

			wait for 5 ns;

			clk <= '1';
			
			wait for 5 ns;

			assert r1 = vr1
				report "1 proc output mismatch"
				severity error;
			
			assert r2 = vr2
				report "2 proc output mismatch"
				severity error;
		end loop;

		wait;
	end process;
end behav;
