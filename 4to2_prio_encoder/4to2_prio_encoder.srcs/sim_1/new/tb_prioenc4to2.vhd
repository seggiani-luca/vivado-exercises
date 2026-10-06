library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_prioenc4to2 is
end tb_prioenc4to2;

architecture Behavioral of tb_prioenc4to2 is

    component prioenc4to2
        port (
            req3_0  : in  std_logic_vector(3 downto 0);
            code1_0 : out std_logic_vector(1 downto 0);
            act0    : out std_logic
        );
    end component;

    signal req3_0  : std_logic_vector(3 downto 0);
    signal code1_0 : std_logic_vector(1 downto 0);
    signal act0    : std_logic;
    
begin

    dut: prioenc4to2
    port map (
        req3_0  => req3_0,
        code1_0 => code1_0,
        act0    => act0
    );
    
    process
    begin
        req3_0 <= "0000"; wait for 10 ns;
        req3_0 <= "0001"; wait for 10 ns;
        req3_0 <= "0010"; wait for 10 ns;
        req3_0 <= "0011"; wait for 10 ns;
        req3_0 <= "0100"; wait for 10 ns;
        req3_0 <= "0101"; wait for 10 ns;
        req3_0 <= "0110"; wait for 10 ns;
        req3_0 <= "0111"; wait for 10 ns;
        req3_0 <= "1000"; wait for 10 ns;
        req3_0 <= "1001"; wait for 10 ns;
        req3_0 <= "1010"; wait for 10 ns;
        req3_0 <= "1011"; wait for 10 ns;
        req3_0 <= "1100"; wait for 10 ns;
        req3_0 <= "1101"; wait for 10 ns;
        req3_0 <= "1110"; wait for 10 ns;
        req3_0 <= "1111"; wait for 10 ns;
    end process;

end Behavioral;

configuration cfg_structural of tb_prioenc4to2 is
    for Behavioral
        for dut: prioenc4to2
            use entity work.prioenc4to2_behavioral_casewhen;
        end for;
    end for;
end cfg_structural;
