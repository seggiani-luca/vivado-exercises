library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sqrt_approx is
	port (
		clk   : in  std_logic;
		rst   : in  std_logic;
		start : in  std_logic;
		a     : in  std_logic_vector(7 downto 0);
		b     : in  std_logic_vector(7 downto 0);
		ready : out std_logic;
		res   : out std_logic_vector(8 downto 0)
	);
end entity sqrt_approx;

architecture hlsm of sqrt_approx is
	type state_type is (Sidle, S1, S2, S3, S4, S5);
	signal state      : state_type := Sidle;
	signal next_state : state_type := Sidle;

	signal t0      : std_logic_vector(8 downto 0);
	signal next_t0 : std_logic_vector(8 downto 0);
	signal t1      : std_logic_vector(8 downto 0);
	signal next_t1 : std_logic_vector(8 downto 0);
	signal t2      : std_logic_vector(8 downto 0);
	signal next_t2 : std_logic_vector(8 downto 0);
begin
	comb : process (state, start, a, b)
	begin
		case state is
			when Sidle =>
				ready <= '0';

				next_t0 <= std_logic_vector(resize(signed(a), 9)); -- t0 loads a, t1 loads b -> t0_load, t1_load
				next_t1 <= std_logic_vector(resize(signed(b), 9));
				next_t2 <= t2;

				if (start = '1') then
					next_state <= S1;
				else
					next_state <= sidle;
				end if;
			when S1 =>
				ready <= '0';
			
				-- t0 <= abs(t0), t1 <= abs(t1)
				next_t0 <= std_logic_vector(abs(signed(t0))); -- t0 abs, t1 abs -> t0_abs, t1_abs
				next_t1 <= std_logic_vector(abs(signed(t1)));
				next_t2 <= t2;

				next_state <= S2;
			when S2 =>
				ready <= '0';

				-- t0 <= min(t0, t1), t1 <= max(t0, t1)
				if unsigned(t0) < unsigned(t1) then -- t0 takes min(t0, t1), t1 takes max(t0, t1) -> t0_min, t1_max
					next_t0 <= t0;
					next_t1 <= t1;
				else
					next_t0 <= t1;
					next_t1 <= t0;
				end if;
				next_t2 <= t2;

				next_state <= S3;
			when S3 =>
				ready <= '0';
				
				next_t0 <= t0;
				next_t1 <= t1;
				-- t2 <= sub(t1, t1 >> 3)
				next_t2 <= std_logic_vector( -- t2 takes t1 - t1 >> 3 -> t2_sub
				    signed(t1) - shift_right(signed(t1), 3)
				);

				next_state <= S4;
			when S4 =>
				ready <= '0';
				
				next_t0 <= t0;
				next_t1 <= t1;
				-- t2 <= add(t1, t0 >> 1);
				next_t2 <= std_logic_vector( -- t2 takes t2 + t0 >> 1 -> t2_add
				    signed(t2) + shift_right(signed(t0), 1)
				);

				next_state <= S5;
			when S5 =>
				ready <= '1';
				
				next_t0 <= t0;
				next_t1 <= t1;
				-- t2 <= max(t0, t2); -- t2 takes max(t0, t2) -> t2_max
				if unsigned(t0) > unsigned(t2) then
					next_t2 <= t0;
				else
					next_t2 <= t2;
				end if;

				next_state <= Sidle;
		end case;
	end process comb;

	regs : process (clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				state <= Sidle;
				t0 <= (others => '0');
				t1 <= (others => '0');
				t2 <= (others => '0');
			else
				state <= next_state;
				t0 <= next_t0;
				t1 <= next_t1;
				t2 <= next_t2;
			end if;
		end if;
	end process regs;

	res <= t2;
end architecture hlsm;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

architecture fsmd of sqrt_approx is
	type state_type is (Sidle, S1, S2, S3, S4, S5);
	signal state      : state_type := Sidle;
	signal next_state : state_type := Sidle;

	signal t0_load, t1_load : std_logic;
	signal t0_abs,  t1_abs  : std_logic;
	signal t0_min,  t1_max  : std_logic;
	signal t2_sub,  t2_add  : std_logic;
	signal t2_max           : std_logic;

	signal t0      : std_logic_vector(8 downto 0);
	signal next_t0 : std_logic_vector(8 downto 0);
	signal t1      : std_logic_vector(8 downto 0);
	signal next_t1 : std_logic_vector(8 downto 0);
	signal t2      : std_logic_vector(8 downto 0);
	signal next_t2 : std_logic_vector(8 downto 0);
begin
	comb_state : process (state, start, a, b)
	begin
		case state is
			when Sidle =>
				ready <= '0';

				t0_load <= '1';
				t1_load <= '1';
				t0_abs  <= '0';
				t1_abs  <= '0';
				t0_min  <= '0';
				t1_max  <= '0';
				t2_sub  <= '0';
				t2_add  <= '0';
				t2_max  <= '0';

				if (start = '1') then
					next_state <= S1;
				else
					next_state <= sidle;
				end if;
			when S1 =>
				ready <= '0';
			
				t0_load <= '0';
				t1_load <= '0';
				t0_abs  <= '1';
				t1_abs  <= '1';
				t0_min  <= '0';
				t1_max  <= '0';
				t2_sub  <= '0';
				t2_add  <= '0';
				t2_max  <= '0';

				next_state <= S2;
			when S2 =>
				ready <= '0';

				t0_load <= '0';
				t1_load <= '0';
				t0_abs  <= '0';
				t1_abs  <= '0';
				t0_min  <= '1';
				t1_max  <= '1';
				t2_sub  <= '0';
				t2_add  <= '0';
				t2_max  <= '0';

				next_state <= S3;
			when S3 =>
				ready <= '0';
				
				t0_load <= '0';
				t1_load <= '0';
				t0_abs  <= '0';
				t1_abs  <= '0';
				t0_min  <= '0';
				t1_max  <= '0';
				t2_sub  <= '1';
				t2_add  <= '0';
				t2_max  <= '0';

				next_state <= S4;
			when S4 =>
				ready <= '0';
				
				t0_load <= '0';
				t1_load <= '0';
				t0_abs  <= '0';
				t1_abs  <= '0';
				t0_min  <= '0';
				t1_max  <= '0';
				t2_sub  <= '0';
				t2_add  <= '1';
				t2_max  <= '0';

				next_state <= S5;
			when S5 =>
				ready <= '1';
				
				t0_load <= '0';
				t1_load <= '0';
				t0_abs  <= '0';
				t1_abs  <= '0';
				t0_min  <= '0';
				t1_max  <= '0';
				t2_sub  <= '0';
				t2_add  <= '0';
				t2_max  <= '1';

				next_state <= Sidle;
		end case;
	end process comb_state;

	comb_regs : process (all)
	begin
		-- t0
		if    (t0_load = '1') then
			next_t0 <= std_logic_vector(resize(signed(a), 9));
		elsif (t0_abs = '1') then
				next_t0 <= std_logic_vector(abs(signed(t0)));
		elsif (t0_min = '1') then
			if unsigned(t0) < unsigned(t1) then
				next_t0 <= t0;
			else
				next_t0 <= t1;
			end if;
		else
			next_t0 <= t0;
		end if;

		-- t1
		if    (t1_load = '1') then
			next_t1 <= std_logic_vector(resize(signed(b), 9));
		elsif (t1_abs = '1') then
				next_t1 <= std_logic_vector(abs(signed(t1)));
		elsif (t1_max = '1') then
			if unsigned(t0) < unsigned(t1) then
				next_t1 <= t1;
			else
				next_t1 <= t0;
			end if;
		else
			next_t1 <= t1;
		end if;

		-- t2
		if    (t2_sub = '1') then
			next_t2 <= std_logic_vector(
				signed(t1) - shift_right(signed(t1), 3)
			);
		elsif (t2_add = '1') then
			next_t2 <= std_logic_vector(
				signed(t2) + shift_right(signed(t0), 1)
			);
		elsif (t2_max = '1') then
			if unsigned(t0) > unsigned(t2) then
				next_t2 <= t0;
			else
				next_t2 <= t2;
			end if;
		else
			next_t2 <= t2;
		end if;
	end process comb_regs;

	regs : process (clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				state <= Sidle;
				t0 <= (others => '0');
				t1 <= (others => '0');
				t2 <= (others => '0');
			else
				state <= next_state;
				t0 <= next_t0;
				t1 <= next_t1;
				t2 <= next_t2;
			end if;
		end if;
	end process regs;

	res <= t2;
end architecture fsmd;
