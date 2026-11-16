library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity manchester is
	port (
		clk    : in  std_logic;
		rst    : in  std_logic;
		valid  : in  std_logic;
		data   : in  std_logic;
		output : out std_logic
	);
end entity manchester;

architecture behavioral of manchester is
	type state_type is (Sidle, Slo0, Slo1, Shi0, Shi1);
	signal state      : state_type := Sidle;
	signal next_state : state_type := Sidle;
begin
	comb : process (state, valid, data)
	begin
		case state is
			when Sidle =>
				output <= '0';

				if valid = '1' then
					if data = '1' then
						next_state <= Shi0;
					else
						next_state <= Slo0;
					end if;
				else
					next_state <= Sidle;
				end if;

			when Slo0  =>
				output <= '0';
				
				if valid = '1' then
					next_state <= Slo1;
				else
					next_state <= Sidle;
				end if;

			when Slo1  =>
				output <= '1';
				
				if valid = '1' then
					if data = '1' then
						next_state <= Shi0;
					else
						next_state <= Slo0;
					end if;
				else
					next_state <= Sidle;
				end if;

			when Shi0  =>
				output <= '1';
				
				if valid = '1' then
					next_state <= Shi1;
				else
					next_state <= Sidle;
				end if;

			when Shi1  =>
				output <= '0';
				
				if valid = '1' then
					if data = '1' then
						next_state <= Shi0;
					else
						next_state <= Slo0;
					end if;
				else
					next_state <= Sidle;
				end if;
		end case;
	end process comb;

	regs : process (clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				state <= Sidle;
			else
				state <= next_state;
			end if;
		end if;
	end process regs;
end architecture behavioral;
