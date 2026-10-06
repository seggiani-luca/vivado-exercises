library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder3to8_behavioral_ifelse is
    port (
        in2_0  : in  std_logic_vector(2 downto 0);
        out7_0 : out std_logic_vector(7 downto 0);
        enb0   : in  std_logic
    );
end decoder3to8_behavioral_ifelse;

architecture Behavioral of decoder3to8_behavioral_ifelse is

begin

    process(in2_0, enb0)
    begin
        if      in2_0 = "000" then
            out7_0 <= (0 => enb0, others => '0');
        elsif in2_0 = "001" then
            out7_0 <= (1 => enb0, others => '0');
        elsif in2_0 = "010" then
            out7_0 <= (2 => enb0, others => '0');
        elsif in2_0 = "011" then
            out7_0 <= (3 => enb0, others => '0');
        elsif in2_0 = "100" then
            out7_0 <= (4 => enb0, others => '0');
        elsif in2_0 = "101" then
            out7_0 <= (5 => enb0, others => '0');
        elsif in2_0 = "110" then
            out7_0 <= (6 => enb0, others => '0');
        elsif in2_0 = "111" then
            out7_0 <= (7 => enb0, others => '0');
        end if;
    
    end process;

end Behavioral;