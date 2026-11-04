library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity self_correct_logic is
	generic (
        WIDTH : positive := 4
	);
	port (
		reg : in  std_logic_vector(WIDTH-1 downto 0);
		lsb : out std_logic
	);
end self_correct_logic; 

architecture behavioral of self_correct_logic is
begin
	lsb <= '1' when reg(WIDTH-2 downto 0) = (WIDTH-2 downto 0 => '0') else
		   '0';
end behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity self_ring_counter is
	generic (
        WIDTH : positive := 4
	);
	port (
		clk   : in  std_logic;
		rst   : in  std_logic;
		enb   : in  std_logic;
		r_reg : out std_logic_vector(WIDTH-1 downto 0)
	);
end self_ring_counter;

architecture behavioral of self_ring_counter is
	signal reg      : std_logic_vector(WIDTH-1 downto 0);
	signal reg_next : std_logic_vector(WIDTH-1 downto 0);
	signal lsb      : std_logic;
begin
	scl : entity work.self_correct_logic
	generic map (
		WIDTH
	)
	port map (
		reg, lsb
	);

	with enb select
		reg_next <= reg(WIDTH-2 downto 0) & lsb when '1',
					reg       					when others;

	regs : process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				reg <= (others => '0');
			else
				reg <= reg_next;
			end if;
		end if;
	end process regs;

	r_reg <= reg;

end behavioral;
