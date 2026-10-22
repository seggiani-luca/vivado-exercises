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
		enb   : in  std_logic;
		cin   : in  std_logic;
		din0  : in  std_logic_vector(WIDTH-1 downto 0);
		din1  : in  std_logic_vector(WIDTH-1 downto 0);
		dout  : out std_logic_vector(WIDTH-1 downto 0);
		cout  : out std_logic;
		ctrl  : in  std_logic_vector(2 downto 0)
	);
end alu;

architecture Dataflow of alu is
	signal result : std_logic_vector(WIDTH downto 0);
begin
	result <= (others => '0')                                                                             when enb = '0'              else
			  std_logic_vector(signed('0' & din0) + to_integer(unsigned'(0 => cin)))                      when std_match(ctrl, "0--") else
	          std_logic_vector(signed('0' & din0) + signed('0' & din1) + to_integer(unsigned'(0 => cin))) when ctrl = "100"           else
	          std_logic_vector(signed('0' & din0) - signed('0' & din1) - to_integer(unsigned'(0 => cin))) when ctrl = "101"           else
		      ('0' & din0) and ('0' & din1)                                                               when ctrl = "110"           else
	          ('0' & din0) or ('0' & din1)                                                                when ctrl = "111"           else
	          (others => 'X');
	dout <= result(WIDTH-1 downto 0);
	cout <= result(WIDTH);
end Dataflow;
