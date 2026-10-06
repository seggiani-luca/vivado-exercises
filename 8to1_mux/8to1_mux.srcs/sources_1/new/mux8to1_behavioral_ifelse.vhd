library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8to1_behavioral_ifelse is
    port (
        in7_0  : in  std_logic_vector(7 downto 0);
        sel2_0 : in  std_logic_vector(2 downto 0);
        out0   : out std_logic
    );
end mux8to1_behavioral_ifelse;

architecture Behavioral of mux8to1_behavioral_ifelse is

begin
    process(in7_0, sel2_0)
    begin
        if    sel2_0 = "000" then
            out0 <= in7_0(0);
        elsif sel2_0 = "001" then
            out0 <= in7_0(1);
        elsif sel2_0 = "010" then
            out0 <= in7_0(2);
        elsif sel2_0 = "011" then
            out0 <= in7_0(3);
        elsif sel2_0 = "100" then
            out0 <= in7_0(4);
        elsif sel2_0 = "101" then
            out0 <= in7_0(5);
        elsif sel2_0 = "110" then
            out0 <= in7_0(6);
        else
            out0 <= in7_0(7);
        end if;
    end process;
    
end Behavioral;
