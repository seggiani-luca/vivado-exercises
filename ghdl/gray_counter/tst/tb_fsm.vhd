library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_gray_counter is
end entity;

architecture Behavioral of tb_gray_counter is
	constant WIDTH : integer := 8;

	signal clk  : std_logic;
	signal rst  : std_logic;
	signal enb  : std_logic;
	signal gout : std_logic_vector(WIDTH-1 downto 0);
begin
	dut: entity work.gray_counter
	generic map (
		WIDTH
	)
	port map (
		clk, rst, enb, gout
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

		for i in 0 to 2**WIDTH loop
			clk <= '0';

			wait for 5 ns;

			clk <= '1';

			wait for 5 ns;
		end loop;

		wait;
	end process;
end Behavioral;
