library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_hamming_distance is
end tb_hamming_distance;

architecture Behavioral of tb_hamming_distance is
    component hamming_distance
        port (
            a7_0   : in std_logic_vector(7 downto 0);
            b7_0   : in std_logic_vector(7 downto 0);
            out3_0 : out std_logic_vector(3 downto 0)
        );
    end component;
    
    signal a7_0   : std_logic_vector(7 downto 0);
    signal b7_0   : std_logic_vector(7 downto 0);
    signal out3_0 : std_logic_vector(3 downto 0);
begin

    dut: hamming_distance
    port map (
        a7_0  => a7_0,
        b7_0  => b7_0,
        out3_0 => out3_0
    );
    
    process
    begin
        -- 1
        a7_0 <= "10011000";
        b7_0 <= "10011100";
        
        wait for 20 ns;
        
        -- 3
        a7_0 <= "11011000";
        b7_0 <= "10011101";
        
        wait for 20 ns;
        
        -- 5
        a7_0 <= "11110010";
        b7_0 <= "10011111";
        
        wait for 20 ns;
        
    end process;

end Behavioral;

configuration cfg_structural of tb_hamming_distance is
    for Behavioral
        for dut: hamming_distance
            use entity work.hamming_distance_structural;
        end for;
    end for;
end cfg_structural;
