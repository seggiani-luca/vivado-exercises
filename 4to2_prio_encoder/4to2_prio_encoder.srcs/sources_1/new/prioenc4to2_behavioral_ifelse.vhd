library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity prioenc4to2_behavioral_ifelse is
    port (
        req3_0  : in  std_logic_vector(3 downto 0);
        code1_0 : out std_logic_vector(1 downto 0);
        act0    : out std_logic
    );
end prioenc4to2_behavioral_ifelse;

architecture Behavioral of prioenc4to2_behavioral_ifelse is

begin
    process(req3_0)
    begin
    
        if   req3_0(3) = '1' then
            code1_0 <= "11";
        elsif req3_0(2) = '1' then
            code1_0 <= "10";
        elsif req3_0(1) = '1' then
            code1_0 <= "01";
        else
            code1_0 <= "00";
        end if;
        
        if req3_0 = "0000" then
            act0 <= '0';
        else
            act0 <= '1';
        end if;
    
    end process;

end Behavioral;
