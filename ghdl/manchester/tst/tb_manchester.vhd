library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_manchester is
end entity tb_manchester;

architecture behavioral of tb_manchester is
	signal clk    : std_logic;	
	signal rst    : std_logic;	
	signal valid  : std_logic;	
	signal data   : std_logic;	
	signal output : std_logic;	
begin
	dut : entity work.manchester(behavioral)
	port map (
		clk, rst, valid, data, output
	);

	stim : process
		file vectors   : text open read_mode is "vectors.txt";
		variable l     : line;
		variable vchar : character;
		variable vvec  : std_logic_vector(7 downto 0);
	begin
		clk <= '0';
		rst <= '1';
		valid <= '0';
		data <= '0';

		wait for 5 ns;

		clk <= '1';

		wait for 5 ns;

		clk <= '0';
		rst <= '0';
		valid <= '1';

		readline(vectors, l);
		while l'length > 0 loop
			read(l, vchar);
			vvec := std_logic_vector(to_unsigned(character'pos(vchar), 8));
			
			for i in 0 to 7 loop
				data <= vvec(i);

				wait for 5 ns;

				clk <= '1';

				wait for 5 ns;

				clk <= '0';

				wait for 5 ns;

				clk <= '1';

				wait for 5 ns;

				clk <= '0';
			end loop;	
		end loop;

		wait;
	end process;

end architecture behavioral;
