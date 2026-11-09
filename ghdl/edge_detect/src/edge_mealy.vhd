library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

architecture mealy of edge is
	type state_type is (S0, S1);
	signal state : state_type := S0;
	signal next_state : state_type := S0;
	signal state_out : std_logic_vector(1 downto 0);
begin
	comb : process (state, i)
	begin
		case state is
			when S0 =>
				o <= i;
				if (i = '1') then
					next_state <= S1;
				elsif (i = '0') then
					next_state <= S0;
				end if;
			when S1 =>
				o <= '0';
				if (i = '0') then
					next_state <= S0;
				elsif (i = '1') then
					next_state <= S1;
				end if;
		end case;
	end process comb;

	regs : process (clk, rst)
	begin
		if (rst = '1') then
			state <= S0;
		elsif (rising_edge(clk)) then
			state <= next_state;
		end if;
	end process regs;

	with state select state_out <=
		"00" when S0,
		"01" when S1;
end architecture mealy;
