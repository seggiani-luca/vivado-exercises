library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity arbiter is
	port (
		rst    : in  std_logic;
		clk    : in  std_logic;
		req0   : in  std_logic;
		req1   : in  std_logic;
		grant0 : out std_logic;
		grant1 : out std_logic
	);
end entity arbiter;
