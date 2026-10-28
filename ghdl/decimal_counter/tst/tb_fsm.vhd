library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_decimal_counter is
end entity;

architecture Behavioral of tb_decimal_counter is
	signal clk    : std_logic;
	signal rst    : std_logic;
	signal enb    : std_logic;
	signal out1   : std_logic_vector(3 downto 0);
	signal out10  : std_logic_vector(3 downto 0);
	signal out100 : std_logic_vector(3 downto 0);
	signal trig   : std_logic;
begin
	dut: entity work.decimal_counter
	port map (
		clk, rst, enb,
		out1, out10, out100, trig
	);

	process
	begin
		rst <= '1';
		clk <= '0';
		enb <= '0';

		wait for 5 ns;

		clk <= '1';

		wait for 5 ns;

		rst <= '0';
		enb <= '1';

		for i in 0 to 1000 loop
			clk <= '0';

			wait for 5 ns;

			clk <= '1';

			wait for 5 ns;
		end loop;

		wait;
	end process;
end Behavioral;
