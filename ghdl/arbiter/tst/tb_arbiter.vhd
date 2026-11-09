library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_arbiter is
end entity;

architecture test of tb_arbiter is
    signal clk    : std_logic := '0';
    signal rst    : std_logic := '0';
    signal req0   : std_logic := '0';
    signal req1   : std_logic := '0';
    signal grant0 : std_logic;
    signal grant1 : std_logic;

    constant T : time := 10 ns;
begin
    clk <= not clk after T / 2;

    dut: entity work.arbiter(fcfs)
        port map (
            clk    => clk,
            rst    => rst,
            req0   => req0,
            req1   => req1,
            grant0 => grant0,
            grant1 => grant1
        );

    stim : process
    begin
        -- Reset
        rst <= '1';
        wait for T;
        rst <= '0';
        wait for T;

        -- Test 1: no requests
        assert grant0 = '0' and grant1 = '0'
            report "FAIL: unexpected grant while idle"
            severity error;

        -- Test 2: subsystem 1 requests
        req1 <= '1';
        wait for T;
        assert grant0 = '0' and grant1 = '1'
            report "FAIL: subsystem 1 not granted"
            severity error;

        -- Subsystem 1 releases
        req1 <= '0';
        wait for T;
        assert grant0 = '0' and grant1 = '0'
            report "FAIL: subsystem 1 grant not released"
            severity error;

        -- Test 3: subsystem 0 requests
        req0 <= '1';
        wait for T;
        assert grant0 = '1' and grant1 = '0'
            report "FAIL: subsystem 0 not granted"
            severity error;

        -- Subsystem 0 releases
        req0 <= '0';
        wait for T;
        assert grant0 = '0' and grant1 = '0'
            report "FAIL: subsystem 0 grant not released"
            severity error;

        -- Test 4: simultaneous requests
        req0 <= '1';
        req1 <= '1';
        wait for T;

        assert grant0 = '0' and grant1 = '1'
            report "FAIL: incorrect priority resolution"
            severity error;

        -- Winner releases, loser still requesting
        req1 <= '0';
        wait for T;

        assert grant0 = '0' and grant1 = '0'
            report "FAIL: unexpected grant transition"
            severity error;

        wait for T;

        assert grant0 = '1' and grant1 = '0'
            report "FAIL: pending request not granted"
            severity error;

        -- Subsystem 1 releases
        req0 <= '0';
        wait for T;

        assert grant0 = '0' and grant1 = '0'
            report "FAIL: subsystem 1 grant not released"
            severity error;

        -- Test 5: simultaneous requests again
        req0 <= '1';
        req1 <= '1';
        wait for T;

        assert grant0 = '1' and grant1 = '0'
            report "FAIL: priority is not deterministic"
            severity error;

        report "All tests completed" severity note;

        wait;
    end process;

end architecture;
