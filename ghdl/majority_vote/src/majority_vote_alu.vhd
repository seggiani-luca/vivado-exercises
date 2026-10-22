library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity majority_vote_alu is
	generic (
        WIDTH : positive := 8
	);
	port (
		a          : in  std_logic_vector(WIDTH-1 downto 0);
		b          : in  std_logic_vector(WIDTH-1 downto 0);
		c          : in  std_logic_vector(WIDTH-1 downto 0);
		d          : in  std_logic_vector(WIDTH-1 downto 0);
		e          : in  std_logic_vector(WIDTH-1 downto 0);
		f          : in  std_logic_vector(WIDTH-1 downto 0);
		ctrl       : in  std_logic_vector(2 downto 0);
		decision   : out std_logic_vector(WIDTH-1 downto 0);
		data_valid : out std_logic
	);
end majority_vote_alu;

architecture Hierarchical of majority_vote_alu is
	signal dout0 : std_logic_vector(WIDTH-1 downto 0);
	signal dout1 : std_logic_vector(WIDTH-1 downto 0);
	signal dout2 : std_logic_vector(WIDTH-1 downto 0);
begin
	alu0: entity work.alu
	generic map (
		WIDTH => WIDTH
	)
	port map (
		din0 => a,
		din1 => b,
		dout => dout0,
		ctrl => ctrl
	);
	
	alu1: entity work.alu
	generic map (
		WIDTH => WIDTH
	)
	port map (
		din0 => c,
		din1 => d,
		dout => dout1,
		ctrl => ctrl
	);
	
	alu2: entity work.alu
	generic map (
		WIDTH => WIDTH
	)
	port map (
		din0 => e,
		din1 => f,
		dout => dout2,
		ctrl => ctrl
	);

	data_valid <= '1' when (dout0 = dout1) or (dout1 = dout2) or (dout0 = dout2) else
				  '0';

	decision <= dout0 when (dout0 = dout1) else
	            dout1 when (dout1 = dout2) else
	            dout0 when (dout0 = dout2) else
	            (others => 'Z');


end Hierarchical;
