library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_multi is
end tb_multi;

architecture Behavioral of tb_multi is
	component multi
		port (
			a : in  std_logic_vector(3 downto 0);
			b : in  std_logic_vector(3 downto 0);
			y : out std_logic_vector(7 downto 0)
		);
	end component;

	signal a : std_logic_vector(3 downto 0);
	signal b : std_logic_vector(3 downto 0);
	signal y : std_logic_vector(7 downto 0);
begin
	dut: multi
	port map (
		a => a,
		b => b,
		y => y
	);

	process
	begin
		a <= "0010";
		b <= "0010";

		wait for 10 ns;

		assert y = "00000100"
			report "wrong result"
			severity failure;
	end process;
end Behavioral;

configuration cfg_structural of tb_multi is
    for Behavioral
        for dut: multi 
            use entity work.multi_smart;
        end for;
    end for;
end cfg_structural;
