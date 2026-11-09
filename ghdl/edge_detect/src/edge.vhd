library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edge is
	port (
		rst : in  std_logic;
		clk : in  std_logic;
		i   : in  std_logic;
		o   : out std_logic
	);
end entity edge;
