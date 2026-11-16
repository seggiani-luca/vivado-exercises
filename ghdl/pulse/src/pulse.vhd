library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pulsegen is
	port (
		clk    : in  std_logic;	
		rst    : in  std_logic;
		go     : in  std_logic;
		stop   : in  std_logic;
		pulse  : out std_logic
	);
end entity pulsegen;
