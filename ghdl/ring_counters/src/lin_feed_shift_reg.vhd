library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lin_feed_shift_reg is
	generic (
        WIDTH : positive := 4;
		TAPS  : std_logic_vector(WIDTH-1 downto 0) := "1100";
		SEED : std_logic_vector(WIDTH-1 downto 0) := (0 => '1', others => '0')
	);
	port (
		clk   : in  std_logic;
		rst   : in  std_logic;
		enb   : in  std_logic;
		r_reg : out std_logic_vector(WIDTH-1 downto 0)
	);
end lin_feed_shift_reg;

architecture behavioral of lin_feed_shift_reg is
	signal reg      : std_logic_vector(WIDTH-1 downto 0);
	signal reg_next : std_logic_vector(WIDTH-1 downto 0);
	signal lsb      : std_logic;
begin
	lsb <= xor (reg and TAPS);

	with enb select
		reg_next <= reg(WIDTH-2 downto 0) & lsb when '1',
					reg       					when others;

	regs : process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				reg <= SEED;
			else
				reg <= reg_next;
			end if;
		end if;
	end process regs;

	r_reg <= reg;

end behavioral;
