library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux8to1 is
end tb_mux8to1;

architecture Behavioral of tb_mux8to1 is

    component mux8to1
        port (
            in7_0  : in  std_logic_vector(7 downto 0);
            sel2_0 : in  std_logic_vector(2 downto 0);
            out0   : out std_logic
        );
    end component;

    signal in7_0  : std_logic_vector(7 downto 0);
    signal sel2_0 : std_logic_vector(2 downto 0);
    signal out0   : std_logic;
    
begin

    dut: mux8to1
    port map (
        in7_0  => in7_0,
        sel2_0 => sel2_0,
        out0   => out0
    );
    
    process
    begin
        in7_0 <= "10101010";
        
        sel2_0 <= "000";
        wait for 10ns;
        
        sel2_0 <= "001";
        wait for 10ns;
        
        sel2_0 <= "010";
        wait for 10ns;
        
        sel2_0 <= "011";
        wait for 10ns;
        
        sel2_0 <= "100";
        wait for 10ns;
        
        sel2_0 <= "101";
        wait for 10ns;
        
        sel2_0 <= "110";
        wait for 10ns;
        
        sel2_0 <= "111";
        wait for 10ns;
    end process;

end Behavioral;

configuration cfg_structural of tb_mux8to1 is
    for Behavioral
        for dut: mux8to1
            use entity work.mux8to1_structural;
        end for;
    end for;
end cfg_structural;