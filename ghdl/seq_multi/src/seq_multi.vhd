library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity seq_multi is
    port (
        clk   : in  std_logic;
        rst   : in  std_logic;
        start : in  std_logic;
        a     : in  std_logic_vector(7 downto 0);
        b     : in  std_logic_vector(7 downto 0);
        ready : out std_logic;
        res   : out std_logic_vector(15 downto 0)
    );
end entity seq_multi;

architecture hlsm of seq_multi is
    type state_type is (Sidle, S1, S2);
    signal state      : state_type := Sidle;
    signal next_state : state_type := Sidle;

    signal areg      : std_logic_vector(15 downto 0);
    signal next_areg : std_logic_vector(15 downto 0);
    signal breg      : std_logic_vector(7 downto 0);
    signal next_breg : std_logic_vector(7 downto 0);
    signal preg      : std_logic_vector(15 downto 0);
    signal next_preg : std_logic_vector(15 downto 0);
    signal cnt       : unsigned(2 downto 0);
    signal next_cnt  : unsigned(2 downto 0);
begin
    comb : process(all)
    begin
        case state is

            when Sidle =>
				ready <= '0';

                next_areg <= std_logic_vector(resize(unsigned(a), 16)); -- a_load
                next_breg <= b;											-- b_load
                next_preg <= (others => '0');							-- p_reset
                next_cnt  <= to_unsigned(7, 3);							-- cnt_init

                if start = '1' then
                    next_state <= S1;
				else
					next_state <= Sidle;
				end if;

            when S1 =>
				ready <= '0';
                
				if breg(0) = '1' then					-- p_acc
                    next_preg <= std_logic_vector(
                        unsigned(preg) + unsigned(areg)
                    );
                end if;

                next_areg <= areg sll 1;				-- a_shift
                next_breg <= breg srl 1;				-- b_shift

                next_cnt <= cnt - 1;					-- cnt_sub

                if (cnt = 0) then
                    next_state <= S2;
				else
					next_state <= S1;
                end if;

            when S2 =>
                ready <= '1';
				
				next_areg <= areg;
				next_breg <= breg;
				next_preg <= preg;
				next_cnt <= cnt;

                next_state <= Sidle;
        end case;
    end process comb;

    regs : process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= Sidle;
                areg <= (others => '0');
                breg <= (others => '0');
                preg <= (others => '0');
                cnt  <= (others => '0');
            else
                state <= next_state;
                areg <= next_areg;
                breg <= next_breg;
                preg <= next_preg;
                cnt  <= next_cnt;
            end if;
        end if;
    end process regs;

    res <= preg;

end architecture hlsm;

architecture fsmd of seq_multi is
    type state_type is (Sidle, S1, S2, S3);
    signal state      : state_type := Sidle;
    signal next_state : state_type := Sidle;

	signal p_acc : std_logic;
	signal a_load, b_load : std_logic;
	signal a_shift, b_shift : std_logic;
	signal p_reset : std_logic;
	signal cnt_init, cnt_sub : std_logic;
	signal cnt_done : std_logic;

    signal areg      : std_logic_vector(15 downto 0);
    signal next_areg : std_logic_vector(15 downto 0);
    signal breg      : std_logic_vector(7 downto 0);
    signal next_breg : std_logic_vector(7 downto 0);
    signal preg      : std_logic_vector(15 downto 0);
    signal next_preg : std_logic_vector(15 downto 0);
    signal cnt       : unsigned(2 downto 0);
    signal next_cnt  : unsigned(2 downto 0);
begin
    comb : process(all)
    begin
        case state is

            when Sidle =>
				ready <= '0';

				p_acc    <= '0';
				a_load   <= '1';
				b_load   <= '1';
				a_shift  <= '0';
				b_shift  <= '0';
				p_reset  <= '1';
				cnt_init <= '1';
				cnt_sub  <= '0';

                if start = '1' then
                    next_state <= S1;
				else
					next_state <= Sidle;
				end if;

            when S1 =>
				ready <= '0';
				
				p_acc    <= '1';
				a_load   <= '0';
				b_load   <= '0';
				a_shift  <= '0';
				b_shift  <= '0';
				p_reset  <= '0';
				cnt_init <= '0';
				cnt_sub  <= '0';
                
				next_state <= S2;

            when S2 =>
				ready <= '0';
				
				p_acc    <= '0';
				a_load   <= '0';
				b_load   <= '0';
				a_shift  <= '1';
				b_shift  <= '1';
				p_reset  <= '0';
				cnt_init <= '0';
				cnt_sub  <= '1';

                if (cnt_done = '1') then
                    next_state <= S3;
				else
					next_state <= S1;
                end if;

            when S3 =>
                ready <= '1';
				
				p_acc    <= '0';
				a_load   <= '0';
				b_load   <= '0';
				a_shift  <= '0';
				b_shift  <= '0';
				p_reset  <= '0';
				cnt_init <= '0';
				cnt_sub  <= '0';

                next_state <= Sidle;
        end case;
    end process comb;

	comb_regs : process(all)
	begin
		-- a
		if (a_load = '1') then
            next_areg <= std_logic_vector(resize(unsigned(a), 16));
		elsif (a_shift = '1') then
			next_areg <= areg sll 1;
		else
			next_areg <= areg;
		end if;
		
		-- b
		if (b_load = '1') then
			next_breg <= b;
		elsif (b_shift = '1') then
			next_breg <= breg srl 1;
		else
			next_breg <= breg;
		end if;

		-- p
		if (p_acc = '1' and breg(0) = '1') then
			next_preg <= std_logic_vector(
				unsigned(preg) + unsigned(areg)
			);
		elsif (p_reset = '1') then
			next_preg <= (others => '0');
		else
			next_preg <= preg;
		end if;

		-- cnt
		if (cnt_sub = '1') then
			next_cnt <= cnt - 1;
		elsif (cnt_init = '1') then
			next_cnt <= to_unsigned(7, 3);
		else
			next_cnt <= cnt;
		end if;

		cnt_done <= '1' when cnt = 0 else '0';
	end process comb_regs;

    regs : process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= Sidle;
                areg <= (others => '0');
                breg <= (others => '0');
                preg <= (others => '0');
                cnt  <= (others => '0');
            else
                state <= next_state;
                areg <= next_areg;
                breg <= next_breg;
                preg <= next_preg;
                cnt  <= next_cnt;
            end if;
        end if;
    end process regs;

    res <= preg;

end architecture fsmd;
