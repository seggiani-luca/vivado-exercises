-- MODULE 1 : DECADE COUNTER

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity decade_counter is
	port (
		clk  : in std_logic;
		rst  : in std_logic;
		enb  : in std_logic;
		cnt  : out std_logic_vector(3 downto 0);
		trig : out std_logic
	);
end entity;

architecture Behavioral of decade_counter is
	signal state      : std_logic_vector(3 downto 0);
	signal next_state : std_logic_vector(3 downto 0);
begin
	comb: process (state, enb)
	begin
		trig <= '1' when state = "1001" else '0';

		if (enb) then
			if (state = "1001") then
				next_state <= "0000";
			else
				next_state <= std_logic_vector(unsigned(state) + 1);
			end if;
		else
			next_state <= state;
		end if;
	end process comb;
	
	regs: process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				state <= "0000";
			else
				state <= next_state;
			end if;
		end if;
	end process regs;

	cnt <= state;
end Behavioral;

-- MODULE 2 : 3 BIT DECIMAL COUNTER

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity decimal_counter is
	port (
		clk    : in  std_logic;
		rst    : in  std_logic;
		enb    : in  std_logic;
		out1   : out std_logic_vector(3 downto 0);
		out10  : out std_logic_vector(3 downto 0);
		out100 : out std_logic_vector(3 downto 0);
		trig   : out std_logic
	);
end entity;

architecture Structural of decimal_counter is
	signal trig9   : std_logic;
	signal trig99  : std_logic;
	signal trig999 : std_logic;
begin
	dec1 : entity work.decade_counter
	port map (
		clk,
		rst,
		enb,
		cnt => out1,
		trig => trig9	
	);

	dec10 : entity work.decade_counter
	port map (
		clk,
		rst,
		trig9,
		cnt => out10,
		trig => trig99	
	);
	
	dec100 : entity work.decade_counter
	port map (
		clk,
		rst,
		trig9 and trig99,
		cnt => out100,
		trig => trig999	
	);

	trig <= trig9 and trig99 and trig999;
end Structural; 
