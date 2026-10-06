library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity prioenc4to2_behavioral_casewhen is
    port (
        req3_0  : in  std_logic_vector(3 downto 0);
        code1_0 : out std_logic_vector(1 downto 0);
        act0    : out std_logic
    );
end prioenc4to2_behavioral_casewhen;

architecture Behavioral of prioenc4to2_behavioral_casewhen is

begin
    
    process(req3_0)
    begin
        
        case req3_0 is
            when "0000" =>
                code1_0 <= "00";
            when "0001" =>
                code1_0 <= "00";
            when "0010" | "0011" =>
                code1_0 <= "01";
            when "0100" | "0101" | "0110" | "0111" =>
                code1_0 <= "10";
            when others =>
                code1_0 <= "11";
        end case;
        
        case req3_0 is
            when "0000" =>
                act0 <= '0';
            when others =>
                act0 <= '1';
        end case;

    end process;

end Behavioral;
