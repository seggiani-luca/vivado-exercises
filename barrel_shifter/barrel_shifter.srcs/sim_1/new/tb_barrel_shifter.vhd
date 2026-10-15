library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_barrel_shifter is
end tb_barrel_shifter;

architecture Behavioral of tb_barrel_shifter is
    component barrel_shifter
        port (
            in7_0  : in  std_logic_vector(7 downto 0);
            lar1_0 : in  std_logic_vector(1 downto 0);
            amt2_0 : in  std_logic_vector(2 downto 0);
            out7_0 : out std_logic_vector(7 downto 0)
        );
    end component;
    
    signal in7_0  : std_logic_vector(7 downto 0);
    signal lar1_0 : std_logic_vector(1 downto 0);
    signal amt2_0 : std_logic_vector(2 downto 0);
    signal out7_0 : std_logic_vector(7 downto 0);
begin
    dut: barrel_shifter
    port map (
        in7_0 => in7_0,
        lar1_0 => lar1_0,
        amt2_0 => amt2_0,
        out7_0 => out7_0
    );

    process
    begin
        in7_0 <= "11010110";
        
        if lar1_0 = "00" then
            lar1_0 <= "01";
        elsif lar1_0 = "01" then
            lar1_0 <= "10"; 
        else
            lar1_0 <= "00";
        end if;
    
        amt2_0 <= "000";
        wait for 10 ns;
        
        amt2_0 <= "001";
        wait for 10 ns;
        
        amt2_0 <= "010";
        wait for 10 ns;
        
        amt2_0 <= "011";
        wait for 10 ns;
        
        amt2_0 <= "100";
        wait for 10 ns;
        
        amt2_0 <= "101";
        wait for 10 ns;
        
        amt2_0 <= "110";
        wait for 10 ns;
        
        amt2_0 <= "111";
        wait for 10 ns;
    end process;
end Behavioral;

configuration cfg_dataflow of tb_barrel_shifter is
    for Behavioral
        for dut: barrel_shifter
            use entity work.barrel_shifter;
        end for;
    end for;
end cfg_dataflow;
