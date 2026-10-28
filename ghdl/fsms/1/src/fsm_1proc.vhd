library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm_1proc is
	port (
		p         : in  std_logic;
		r         : out std_logic;
		clk       : in  std_logic;
		rst       : in  std_logic
	);
end fsm_1proc;

architecture behav of fsm_1proc is
	type state_type is (A, B, C, D);
	signal state     : state_type := A;
	signal state_out : std_logic_vector(1 downto 0);
begin
	process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				state <= A;
				r <= '0';
			else
				case state is
					when A =>
						r <= '0';
						if (p = '1') then
							state <= B;
						end if;
					when B =>
						r <= '0';
						if (p = '1') then
							state <= C;
						end if;
					when C =>
						r <= '0';
						if (p = '1') then
							state <= D;
						end if;
					when D =>
						r <= '1';
						if (p = '1') then
							state <= B;
						else
							state <= A;
						end if;
				end case;
			end if;
		end if;
	end process;

	with state select state_out <=
		"00" when A,
		"01" when B,
		"10" when C,
		"11" when D;
end behav;
