library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8to1_behavioral_casewhen is
    port (
        in7_0  : in  std_logic_vector(7 downto 0);
        sel2_0 : in  std_logic_vector(2 downto 0);
        out0   : out std_logic
    );
end mux8to1_behavioral_casewhen;

architecture Behavioral of mux8to1_behavioral_casewhen is

begin
    process(in7_0, sel2_0)
    begin
        case sel2_0 is
            when "000" =>
                out0 <= in7_0(0);
            when "001" =>
                out0 <= in7_0(1);
            when "010" =>
                out0 <= in7_0(2);
            when "011" =>
                out0 <= in7_0(3);
            when "100" =>
                out0 <= in7_0(4);
            when "101" =>
                out0 <= in7_0(5);
            when "110" =>
                out0 <= in7_0(6);
            when "111" =>
                out0 <= in7_0(7);
            when others =>
                out0 <= 'X';
        end case;
    end process;
    
end Behavioral;
