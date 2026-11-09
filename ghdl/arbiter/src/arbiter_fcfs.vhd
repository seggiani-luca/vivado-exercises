library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

architecture fcfs of arbiter is
	-- SR0 is SR with prio to 0, ...
	type state_type is (SR0, SR1, S0, S1);
	signal state      : state_type := SR0;
	signal next_state : state_type := SR0;
begin
	comb : process (state, req0, req1)
	begin
		case state is
			when SR0 =>
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
					next_state <= SR0;
				end if;
			when SR1 =>
				grant0 <= '0';
				grant1 <= '0';

				if (req0 = '1' and req1 = '1') then
					-- tiebreak
					next_state <= S1;
				elsif (req0 = '1') then
					next_state <= S0;
				elsif (req1 = '1') then
					next_state <= S1;
				else
					next_state <= SR1;
				end if;
			when S0 =>
				grant0 <= '1';
				grant1 <= '0';

				if (req0 = '0') then
					next_state <= SR1;
				else
					next_state <= S0;
				end if;
			when S1 =>
				grant0 <= '0';
				grant1 <= '1';
				
				if (req1 = '0') then
					next_state <= SR0;
				else
					next_state <= S1;
				end if;
			end case;
	end process comb;

	regs : process (clk, rst)
	begin
		if (rst = '1') then
			state <= SR0;
		elsif (rising_edge(clk)) then
			state <= next_state;
		end if;
	end process;
end architecture fcfs;
