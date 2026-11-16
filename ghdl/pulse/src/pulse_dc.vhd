library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pulsegen_datapath is
	port (
		clk    : in  std_logic;	
		rst    : in  std_logic;
		
		go    : in  std_logic;

		down  : in  std_logic;
		shift : in  std_logic;
		load  : in  std_logic;
		load3 : in  std_logic;
		done  : out std_logic;

		pulses : in std_logic;
		pulse  : out std_logic
	);
end entity pulsegen_datapath;

architecture behav of pulsegen_datapath is
    signal count      : std_logic_vector(2 downto 0);
    signal next_count : std_logic_vector(2 downto 0);

    signal max        : std_logic_vector(2 downto 0);
    signal next_max   : std_logic_vector(2 downto 0);
begin
	comb : process (all)
	begin
		next_count <= count;
		next_max <= max;

		pulse <= pulses;
		if count = "001" then
			done <= '1';
		else
			done <= '0';
		end if;

		if down = '1' then
            next_count <= std_logic_vector(unsigned(count) - 1);
		end if;

		if shift = '1' then
            next_max <= max(1 downto 0) & go;
		end if;

		if load = '1' then
			next_count <= next_max;
		end if;

		if load3 = '1' then
			next_count <= "011";
		end if;
	end process comb;

	regs : process (clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				count <= "000";
				max   <= "000";
			else
				count <= next_count;
				max   <= next_max;
			end if;
		end if;
	end process regs;
end architecture behav;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pulsegen_controller is
	port (
		clk    : in  std_logic;	
		rst    : in  std_logic;

		go     : in  std_logic;
		stop   : in  std_logic;

		down  : out std_logic;
		shift : out std_logic;
		load  : out std_logic;
		load3 : out std_logic;
		done  : in  std_logic;
		
		pulses : out std_logic
	);
end entity pulsegen_controller;

architecture behav of pulsegen_controller is
    type state_type is (Sidle, Sprog, Sload, Swait);
	signal state      : state_type := Sidle;
	signal next_state : state_type := Sidle;
begin
	comb : process (state, go, stop, done)
	begin
		next_state <= state;

		down   <= '0';
		shift  <= '0';
		load   <= '0';
		load3  <= '0';
		pulses <= '0';

		case state is
			when Sidle =>
                if go = '1' and stop = '1' then
                    next_state <= Sprog;
                elsif go = '1' and stop = '0' then
                    next_state <= Sload;
                end if;

				load3 <= '1';

			when Sprog =>
                if done = '1' then
                    next_state <= Sidle;
                end if;

				down <= '1';
				shift <= '1';

			when Sload =>
				next_state <= Swait;
				
				load <= '1';

			when Swait =>
				if done = '1' or stop = '1' then
                    next_state <= Sidle;
                end if;

				pulses <= '1';
				down <= '1';

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
end architecture behav;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

architecture dc of pulsegen is
    signal down     : std_logic;
    signal shift    : std_logic;
    signal load     : std_logic;
    signal load3    : std_logic;
    signal done     : std_logic;
    signal pulses   : std_logic;
begin
    datapath : entity work.pulsegen_datapath
        port map (
            clk      => clk,
            rst      => rst,
            go       => go,
            down     => down,
            shift    => shift,
            load     => load,
            load3    => load3,
            done     => done,
            pulses   => pulses,
            pulse    => pulse
        );

    controller : entity work.pulsegen_controller
        port map (
            clk      => clk,
            rst      => rst,
            go       => go,
            stop     => stop,
            down     => down,
            shift    => shift,
            load     => load,
            load3    => load3,
            done     => done,
            pulses   => pulses
        );
end architecture dc;
