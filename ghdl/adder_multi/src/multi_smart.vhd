library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multi_smart is
	port (
		a : in  std_logic_vector(3 downto 0);
		b : in  std_logic_vector(3 downto 0);
		y : out std_logic_vector(7 downto 0)
	);
end multi_smart;

architecture Dataflow of multi_smart is
	signal ps0 : std_logic_vector(3 downto 0);
	signal ps1 : std_logic_vector(3 downto 0);
	signal ps2 : std_logic_vector(3 downto 0);
	signal ps3 : std_logic_vector(3 downto 0);
	
	signal pp0 : std_logic_vector(4 downto 0);
	signal pp1 : std_logic_vector(4 downto 0);
	signal pp2 : std_logic_vector(4 downto 0);
	signal pp3 : std_logic_vector(4 downto 0);
begin

	ps0 <= (b and (b'range => a(0)));
	ps1 <= (b and (b'range => a(1)));
	ps2 <= (b and (b'range => a(2)));
	ps3 <= (b and (b'range => a(3)));

	pp0 <= '0' & ps0;
	pp1 <= std_logic_vector(
		('0' & unsigned(ps1)) + ('0' & unsigned(pp0(4 downto 1)))
	);
	pp2 <= std_logic_vector(
		('0' & unsigned(ps2)) + ('0' & unsigned(pp1(4 downto 1)))
	);
	pp3 <= std_logic_vector(
		('0' & unsigned(ps3)) + ('0' & unsigned(pp2(4 downto 1)))
	);

	y(7 downto 3) <= pp3;
	y(2)          <= pp2(0);
	y(1)          <= pp1(0);
	y(0)          <= pp0(0);

end Dataflow;
