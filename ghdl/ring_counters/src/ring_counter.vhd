library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_flip_flop is
	port (
		clk : in  std_logic;
		enb : in  std_logic;
		d   : in  std_logic;
		q   : out std_logic
	);
end d_flip_flop;

architecture behavioral of d_flip_flop is
begin
	regs : process(clk)
	begin
		if (rising_edge(clk)) then
			if enb = '1' then
				q <= d;
			end if;
		end if;
	end process regs;
end behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ring_counter is
	generic (
        WIDTH : positive := 4
	);
	port (
		clk   : in  std_logic;
		rst   : in  std_logic;
		enb   : in  std_logic;
		r_reg : out std_logic_vector(WIDTH-1 downto 0)
	);
end ring_counter;

architecture behavioral of ring_counter is
	signal reg      : std_logic_vector(WIDTH-1 downto 0);
	signal reg_next : std_logic_vector(WIDTH-1 downto 0);
begin
	with enb select
		reg_next <= reg rol 1 when '1',
					reg       when others;

	regs : process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				reg <= (0 => '1', others => '0');
			else
				reg <= reg_next;
			end if;
		end if;
	end process regs;

	r_reg <= reg;

end behavioral;

architecture structural of ring_counter is
	signal d_bus : std_logic_vector(WIDTH-1 downto 0);
	signal q_bus : std_logic_vector(WIDTH-1 downto 0);
begin
	gen_d_flip_flops: for i in 0 to WIDTH-1 generate
		dff : entity work.d_flip_flop
		port map (
			clk => clk,
			enb => enb or rst,
			d => d_bus(i),
			q => q_bus((i + 1) mod WIDTH)
		);
	end generate;

	with rst select
		d_bus <= q_bus                           when '0',
				 '1' & (WIDTH-2 downto 0 => '0') when others;

	r_reg <= q_bus;
end structural;
