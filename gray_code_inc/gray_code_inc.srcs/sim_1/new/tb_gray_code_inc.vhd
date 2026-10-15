library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_gray_code_inc is
end tb_gray_code_inc;

architecture Behavioral of tb_gray_code_inc is
    signal bin  : std_logic_vector(3 downto 0) := (3 downto 0 => '0');
    signal gin  : std_logic_vector(3 downto 0);
    signal gout : std_logic_vector(3 downto 0);
begin
    ggen : entity work.bin_to_gray
    generic map (
        WIDTH => 4
    )
    port map (
        bin  => bin,
        gout => gin
    );
    
    dut: entity work.gray_code_inc
    generic map (
        WIDTH => 4
    )
    port map (
        gin => gin,
        gout => gout
    );
    
    process
    begin
        wait for 10 ns;
        bin <= std_logic_vector(unsigned(bin) + 1);
    end process;

end Behavioral;