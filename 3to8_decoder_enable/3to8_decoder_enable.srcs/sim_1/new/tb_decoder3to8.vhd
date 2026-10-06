library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_decoder3to8 is
end tb_decoder3to8;

architecture Behavioral of tb_decoder3to8 is

    component decoder3to8
        port (
            in2_0  : in  std_logic_vector(2 downto 0);
            out7_0 : out std_logic_vector(7 downto 0);
            enb0   : in  std_logic
        );
    end component;

    signal in2_0  : std_logic_vector(2 downto 0);
    signal out7_0 : std_logic_vector(7 downto 0);
    signal enb0   : std_logic;
    
begin

    dut: decoder3to8
    port map (
        in2_0  => in2_0,
        out7_0 => out7_0,
        enb0   => enb0
    );
    
    process
    begin
        if enb0 = '1' then
            enb0 <= '0';
        else
            enb0 <= '1';
        end if;
        
        in2_0 <= "000";
        wait for 10ns;
        
        in2_0 <= "001";
        wait for 10ns;
        
        in2_0 <= "010";
        wait for 10ns;
        
        in2_0 <= "011";
        wait for 10ns;
        
        in2_0 <= "100";
        wait for 10ns;
        
        in2_0 <= "101";
        wait for 10ns;
        
        in2_0 <= "110";
        wait for 10ns;
        
        in2_0 <= "111";
        wait for 10ns;
    end process;

end Behavioral;

configuration cfg_structural of tb_decoder3to8 is
    for Behavioral
        for dut: decoder3to8
            use entity work.decoder3to8_behavioral_casewhen;
        end for;
    end for;
end cfg_structural;
