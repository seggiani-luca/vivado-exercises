library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_majority_vote_alu is
end tb_majority_vote_alu;

architecture Behavioral of tb_majority_vote_alu is
	constant WIDTH : positive := 8;

    signal a          : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal b          : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal c          : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal d          : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal e          : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal f          : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal ctrl       : std_logic_vector(2 downto 0)       := (others => '0');
	signal decision   : std_logic_vector(WIDTH-1 downto 0);
	signal data_valid : std_logic;
begin
	dut: entity work.majority_vote_alu
	generic map (
		WIDTH => WIDTH
	)
	port map (
		a => a,
		b => b,
		c => c,
		d => d,
		e => e,
		f => f,
		ctrl => ctrl,
		decision => decision,
		data_valid => data_valid
	);

	process
	begin
		-- test 0: all ALUs agree
		ctrl <= "110"; -- and
		a <= "01010101";
		b <= "00110011";
		c <= "01010101";
		d <= "00110011";
		e <= "01010101";
		f <= "00110011";

		wait for 10 ns;

		assert data_valid = '1'
			report "data_valid wrong in test 0"
			severity failure;
		assert decision = "00010001"
			report "decision wrong in test 0"
			severity failure;

		-- test 1: ALU0 and ALU1 agree 
		ctrl <= "111"; -- or
		a <= "01010101";
		b <= "00110011";
		c <= "01010101";
		d <= "00110011";
		e <= "11010100";
		f <= "00110010";

		wait for 10 ns;

		assert data_valid = '1'
			report "data_valid wrong in test 1"
			severity failure;
		assert decision = "01110111"
			report "decision wrong in test 1"
			severity failure;

		-- test 2: ALU0 and ALU2 agree 
		ctrl <= "111"; -- or
		a <= "01010101";
		b <= "00110011";
		c <= "01110101";
		d <= "00110000";
		e <= "01010101";
		f <= "00110011";

		wait for 10 ns;

		assert data_valid = '1'
			report "data_valid wrong in test 2"
			severity failure;
		assert decision = "01110111"
			report "decision wrong in test 2"
			severity failure;

		-- test 3: ALU1 and ALU2 agree 
		ctrl <= "111"; -- or
		a <= "00000000";
		b <= "00110011";
		a <= "01010101";
		b <= "00110011";
		e <= "01010101";
		f <= "00110011";

		wait for 10 ns;

		assert data_valid = '1'
			report "data_valid wrong in test 3"
			severity failure;
		assert decision = "01110111"
			report "decision wrong in test 3"
			severity failure;

		-- test 4: nobody agrees 
		ctrl <= "111"; -- or
		a <= "00000000";
		b <= "00110001";
		c <= "01010011";
		d <= "00110011";
		e <= "01010101";
		f <= "00110011";

		wait for 10 ns;

		assert data_valid = '0'
			report "data_valid wrong in test 4"
			severity failure;
		assert decision = "ZZZZZZZZ"
			report "decision wrong in test 4"
			severity failure;

	end process;

end Behavioral; 
