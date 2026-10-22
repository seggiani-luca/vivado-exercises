library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- a variable width ALU allowing for the following operations:
-- ctrl | result
-- -----+-------------------
-- 0XX  | dout = din0 + 1
-- 100  | dout = din0 + din1
-- 101  | dout = din0 - din1
-- 110  | dout = din0 & din1
-- 111  | dout = din0 | din1

entity alu is
	generic (
        WIDTH : positive := 8
	);
	port (
		din0  : in  std_logic_vector(WIDTH-1 downto 0);
		din1  : in  std_logic_vector(WIDTH-1 downto 0);
		dout  : out std_logic_vector(WIDTH-1 downto 0);
		ctrl  : in  std_logic_vector(2 downto 0)
	);
end alu;

architecture Dataflow of alu is
begin
	dout <= std_logic_vector(signed(din0) + 1)            when std_match(ctrl, "0--") else
	        std_logic_vector(signed(din0) + signed(din1)) when ctrl = "100"           else
	        std_logic_vector(signed(din0) - signed(din1)) when ctrl = "101"           else
	        din0 and din1                                 when ctrl = "110"           else
	        din0 or din1                                  when ctrl = "111"           else
	        (others => 'X');
end Dataflow;
