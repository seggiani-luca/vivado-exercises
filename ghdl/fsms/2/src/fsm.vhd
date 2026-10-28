library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm is
	port (
		clk : in  std_logic;
		rst : in  std_logic;
		dir : in  std_logic; -- 1: up, 0: down
		cnt : out std_logic_vector(3 downto 0)
	);
end fsm;

architecture behav of fsm is
	type state_type is (s0, s1, s2, s3);
	signal state      : state_type;
	signal next_state : state_type;

	signal state_out      : std_logic_vector(3 downto 0);
	signal next_state_out : std_logic_vector(3 downto 0);
begin
	comb: process (state, dir)
	begin
		cnt <= "1000";

		case (state) is
			when s0 =>
				if (dir = '1') then
					next_state <= s1;
					cnt <= "0100";
				else
					next_state <= s3;
					cnt <= "0001";
				end if;
			when s1 =>
				if (dir = '1') then
					next_state <= s2;
					cnt <= "0010";
				else
					next_state <= s0;
					cnt <= "1000";
				end if;
			when s2 =>
				if (dir = '1') then
					next_state <= s3;
					cnt <= "0001";
				else
					next_state <= s1;
					cnt <= "0100";
				end if;
			when s3 =>
				if (dir = '1') then
					next_state <= s0;
					cnt <= "1000";
				else
					next_state <= s2;
					cnt <= "0010";
				end if;
		end case;
	end process comb; 
	
	regs: process (clk)
	begin
		if rst = '1' then
			state <= s0;
		elsif rising_edge(clk) then
			state <= next_state;
		end if;
	end process regs; 

	with state select state_out <=
		"1000" when s0,
		"0100" when s1,
		"0010" when s2,
		"0001" when s3;
	
	with next_state select next_state_out <=
		"1000" when s0,
		"0100" when s1,
		"0010" when s2,
		"0001" when s3;
end behav;
