library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

entity tb_fsm is
end entity;

architecture behav of tb_fsm is
	signal clk : std_logic;
	signal rst : std_logic;
	signal dir : std_logic;
	signal cnt : std_logic_vector(3 downto 0);
begin
	dut: entity work.fsm
	port map (clk, rst, dir, cnt);

	process
		file vectors : text open read_mode is "vectors.txt";
		variable l : line;
		variable vrst, vdir : std_logic;
		variable vcnt : std_logic_vector(3 downto 0);
	begin
		while not endfile(vectors) loop
			readline(vectors, l);

			read(l, vrst);
			read(l, vdir);
			read(l, vcnt);

			clk <= '0';
			rst <= vrst;
			dir <= vdir;

			wait for 5 ns;

			clk <= '1';
			
			wait for 5 ns;

			assert cnt = vcnt
				report "mismatch on cnt"
				severity error;
		end loop;

		wait;
	end process;
end behav;
