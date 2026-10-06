library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder3to8_behavioral_casewhen is
    port (
        in2_0  : in  std_logic_vector(2 downto 0);
        out7_0 : out std_logic_vector(7 downto 0);
        enb0   : in  std_logic
    );
end decoder3to8_behavioral_casewhen;

architecture Behavioral of decoder3to8_behavioral_casewhen is

begin

    process(in2_0, enb0)
    begin
        case in2_0 is
            when "000" =>
                out7_0 <= (0 => enb0, others => '0');
            when "001" =>
                out7_0 <= (1 => enb0, others => '0');
            when "010" =>
                out7_0 <= (2 => enb0, others => '0');
            when "011" =>
                out7_0 <= (3 => enb0, others => '0');
            when "100" =>
                out7_0 <= (4 => enb0, others => '0');
            when "101" =>
                out7_0 <= (5 => enb0, others => '0');
            when "110" =>
                out7_0 <= (6 => enb0, others => '0');
            when "111" =>
                out7_0 <= (7 => enb0, others => '0');
            when others =>
                out7_0 <= "XXXXXXXX";
        end case;
    
    end process;

end Behavioral;