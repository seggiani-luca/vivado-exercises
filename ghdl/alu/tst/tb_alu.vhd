library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_alu is
end tb_alu;

architecture Behavioral of tb_alu is
    constant WIDTH : positive := 4;

    signal din0 : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal din1 : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal dout : std_logic_vector(WIDTH-1 downto 0);
    signal ctrl : std_logic_vector(2 downto 0) := (others => '0');
begin

    uut : entity work.alu
        generic map (
            WIDTH => WIDTH
        )
        port map (
            din0 => din0,
            din1 => din1,
            dout => dout,
            ctrl => ctrl
        );

    process
    begin
        -- Increment: din0 + 1
        ctrl <= "000";
        din0 <= "0011";
        din1 <= "0001";
        wait for 10 ns;

        -- Addition: din0 + din1
        ctrl <= "100";
        din0 <= "0011";
        din1 <= "0010";
        wait for 10 ns;

        -- Subtraction: din0 - din1
        ctrl <= "101";
        din0 <= "0011";
        din1 <= "0101";
        wait for 10 ns;

        -- AND
        ctrl <= "110";
        din0 <= "1010";
        din1 <= "1100";
        wait for 10 ns;

        -- OR
        ctrl <= "111";
        din0 <= "1010";
        din1 <= "1100";
        wait for 10 ns;

        -- Signed addition: -3 + 2 = -1
        ctrl <= "100";
        din0 <= "1101";
        din1 <= "0010";
        wait for 10 ns;

        -- Signed subtraction: -2 - 3 = -5
        ctrl <= "101";
        din0 <= "1110";
        din1 <= "0011";
        wait for 10 ns;

        -- Invalid control: expect X
        ctrl <= "011";
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
