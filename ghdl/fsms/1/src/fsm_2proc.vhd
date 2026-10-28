library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm_2proc is
	port (
		p   : in  std_logic;
		r   : out std_logic;
		clk : in  std_logic;
		rst : in  std_logic
	);
end fsm_2proc;

architecture behav of fsm_2proc is
	type state_type is (A, B, C, D);
	signal state          : state_type := A;
	signal state_out      : std_logic_vector(3 downto 0);
	signal next_state     : state_type;
	signal next_state_out : std_logic_vector(3 downto 0);
begin
	comb : process(state, p)
	begin
		case state is
			when A =>
				r <= '0';
				if (p = '1') then
					next_state <= B;
				end if;
			when B =>
				r <= '0';
				if (p = '1') then
					next_state <= C;
				end if;
			when C =>
				r <= '0';
				if (p = '1') then
					next_state <= D;
				end if;
			when D =>
				r <= '1';
				if (p = '1') then
					next_state <= B;
				else
					next_state <= A;
				end if;
		end case;
	end process;

	regs : process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				state <= A;
			else
				state <= next_state;
			end if;
		end if;
	end process;

	with state select state_out <=
		"0001" when A,
		"0010" when B,
		"0100" when C,
		"1000" when D;
	
	with next_state select next_state_out <=
		"0001" when A,
		"0010" when B,
		"0100" when C,
		"1000" when D;
end behav;
