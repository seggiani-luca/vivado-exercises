library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

architecture fixed of arbiter is
	type state_type is (SR, S0, S1);
	signal state      : state_type := SR;
	signal next_state : state_type := SR;
begin
	comb : process (state, req0, req1)
	begin
		case state is
			when SR =>
				grant0 <= '0';
				grant1 <= '0';

				if (req0 = '1' and req1 = '1') then
					-- tiebreak
					next_state <= S0;
				elsif (req0 = '1') then
					next_state <= S0;
				elsif (req1 = '1') then
					next_state <= S1;
				else
					next_state <= SR;
				end if;
			when S0 =>
				grant0 <= '1';
				grant1 <= '0';

				if (req0 = '0') then
					next_state <= SR;
				else
					next_state <= S0;
				end if;
			when S1 =>
				grant0 <= '0';
				grant1 <= '1';
				
				if (req1 = '0') then
					next_state <= SR;
				else
					next_state <= S1;
				end if;
			end case;
	end process comb;

	regs : process (clk, rst)
	begin
		if (rst = '1') then
			state <= SR;
		elsif (rising_edge(clk)) then
			state <= next_state;
		end if;
	end process;
end architecture fixed;
