library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multi_dumb is
	port (
		a : in  std_logic_vector(3 downto 0);
		b : in  std_logic_vector(3 downto 0);
		y : out std_logic_vector(7 downto 0)
	);
end multi_dumb;

architecture Dataflow of multi_dumb is
	signal ps0 : std_logic_vector(7 downto 0);
	signal ps1 : std_logic_vector(7 downto 0);
	signal ps2 : std_logic_vector(7 downto 0);
	signal ps3 : std_logic_vector(7 downto 0);
begin

	ps0 <= ("0000" & (b and (b'range => a(0))));
	ps1 <= ("000"  & (b and (b'range => a(1))) & '0');
	ps2 <= ("00"   & (b and (b'range => a(2))) & "00");
	ps3 <= ("0"    & (b and (b'range => a(3))) & "000");

	y <= std_logic_vector(
		 unsigned(ps0) + unsigned(ps1) + unsigned(ps2) + unsigned(ps3)
	 );

end Dataflow;
