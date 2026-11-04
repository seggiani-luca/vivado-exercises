library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ring_counter is
end entity;

architecture behavioral of tb_ring_counter is
	signal clk   : std_logic;
	signal rst   : std_logic;
	signal enb   : std_logic;
	signal r_reg : std_logic_vector(7 downto 0);
begin
	dut : entity work.bruj_shift_reg
	generic map (
		WIDTH => 8,
		TAPS => "10111000"
	)
	port map (
		clk, rst, enb, r_reg
	);

	process
	begin
		rst <= '1';
		enb <= '0';
		clk <= '0';

		wait for 5 ns;

		clk <= '1';

		wait for 5 ns;

		rst <= '0';
		enb <= '1';

		for i in 0 to 256 loop
			clk <= '0';

			wait for 5 ns;

			clk <= '1';

			wait for 5 ns;
		end loop;

		wait;
	end process;
end architecture behavioral;
