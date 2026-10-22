library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_reconfigurable_alu is
end entity;

architecture Behavioral of tb_reconfigurable_alu is
	signal nibble : std_logic_vector(3 downto 0);
	signal din0   : std_logic_vector(15 downto 0);
	signal din1   : std_logic_vector(15 downto 0);
	signal ctrl   : std_logic_vector(2 downto 0);
	signal dout   : std_logic_vector(15 downto 0);
begin
	dut: entity work.reconfigurable_alu
	port map (
		nibble => nibble,
		din0   => din0,
		din1   => din1,
		ctrl   => ctrl,
		dout   => dout
	);

	process
	begin

	nibble <= B"1111";

	-- test 0 : incrementer
	ctrl <= B"000";
	din0 <= B"1000_0000_0000_0000";
	din1 <= B"0000_0000_0000_0000";

	wait for 10 ns;

	assert dout = B"1000_0000_0000_0001"
		report "dout invalid in test 0"
		severity failure;
	
	-- test 1 : incrementer overflow
	ctrl <= B"000";
	din0 <= B"1111_1111_1111_1111";
	din1 <= B"0000_0000_0000_0000";

	wait for 10 ns;

	assert dout = B"0000_0000_0000_0000"
		report "dout invalid in test 1"
		severity failure;
	
	-- test 2 : sum 
	ctrl <= B"100";
	din0 <= B"0101_0000_1111_0001";
	din1 <= B"1010_0000_0001_0001";

	wait for 10 ns;

	assert dout = B"1111_0001_0000_0010"
		report "dout invalid in test 2"
		severity failure;

	-- test 3 : subtract 
	ctrl <= B"101";
	din0 <= B"0000_0000_1110_0001";
	din1 <= B"0000_0000_1111_0001";

	wait for 10 ns;

	assert dout = B"1111_1111_1111_0000"
		report "dout invalid in test 3"
		severity failure;

	-- test 4 : and 
	ctrl <= B"110";
	din0 <= B"0101_1010_0101_1010";
	din1 <= B"1010_0101_1010_0101";

	wait for 10 ns;

	assert dout = B"0000_0000_0000_0000"
		report "dout invalid in test 4"
		severity failure;
	
	-- test 5 : or
	ctrl <= B"111";
	din0 <= B"0101_1010_0101_1010";
	din1 <= B"1010_0101_1010_0101";

	wait for 10 ns;

	assert dout = B"1111_1111_1111_1111"
		report "dout invalid in test 5"
		severity failure;

	-- test 6 : no nibbles enabled
	nibble <= B"0000";
	ctrl <= B"100";
	din0 <= B"0000_0000_0000_1111";
	din1 <= B"0000_0000_0000_0001";

	wait for 10 ns;

	assert dout = B"0000_0000_0000_0000"
		report "dout invalid in test 6"
		severity failure;

	-- test 7 : only nibble 0 enabled
	nibble <= B"0001";
	ctrl <= B"100";
	din0 <= B"0000_0000_0000_1111";
	din1 <= B"0000_0000_0000_0001";

	wait for 10 ns;

	assert dout = B"0000_0000_0000_0000"
		report "dout invalid in test 7"
		severity failure;

	-- test 8 : nibbles 0 and 1 enabled
	nibble <= B"0011";
	ctrl <= B"100";
	din0 <= B"0000_0000_0000_1111";
	din1 <= B"0000_0000_0000_0001";

	wait for 10 ns;

	assert dout = B"0000_0000_0001_0000"
		report "dout invalid in test 8"
		severity failure;

	-- test 9 : all nibbles enabled
	nibble <= B"1111";
	ctrl <= B"100";
	din0 <= B"1111_1111_1111_1111";
	din1 <= B"0000_0000_0000_0001";

	wait for 10 ns;

	assert dout = B"0000_0000_0000_0000"
		report "dout invalid in test 9"
		severity failure;

	-- test 10 : nibbles 0 and 2 enabled
	nibble <= B"0101";
	ctrl <= B"100";
	din0 <= B"0000_0000_0000_1111";
	din1 <= B"0000_0000_0000_0001";

	wait for 10 ns;

	assert dout = B"0000_0001_0000_0000"
		report "dout invalid in test 10"
		severity failure;

	end process;
end Behavioral;
