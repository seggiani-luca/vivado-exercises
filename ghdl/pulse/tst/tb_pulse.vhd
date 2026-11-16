library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_pulse is
end entity tb_pulse;

architecture behavioral of tb_pulse is
	signal clk    : std_logic;	
	signal rst    : std_logic;
	signal go     : std_logic;
	signal stop   : std_logic;
	signal pulse  : std_logic;
begin
	dut : entity work.pulsegen(dc)
	port map (
		clk, rst, go, stop, pulse
	);

    stim : process
    begin
        -- Reset
        rst <= '1';
		clk <= '0';

		wait for 5 ns;

        rst <= '0';
		clk <= '1';

		wait for 5 ns;

        -- Enter programming mode
		clk <= '0';
        go   <= '1';
        stop <= '1';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;

        -- Feed max = 101, MSB first
		clk <= '0';
        go <= '1';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;

		clk <= '0';
        go <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;

		clk <= '0';
        go <= '1';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;

        -- Leave programming mode
		clk <= '0';
        go   <= '0';
        stop <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;

        -- One idle cycle
		clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;

        -- Start pulse generation
		go <= '1';
		clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;
		
		go <= '0';
		clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;

		for i in 0 to 7 loop
			clk <= '0';
			wait for 5 ns;
			clk <= '1';
			wait for 5 ns;
		end loop;

        wait;
    end process;

end architecture behavioral;
