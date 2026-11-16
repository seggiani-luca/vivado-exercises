architecture hlsm of pulsegen is
    type state_type is (Sidle, Sprog, Sload, Swait);
    signal state      : state_type := Sidle;
    signal next_state : state_type := Sidle;

    signal count      : std_logic_vector(2 downto 0);
    signal next_count : std_logic_vector(2 downto 0);

    signal max        : std_logic_vector(2 downto 0);
    signal next_max   : std_logic_vector(2 downto 0);
begin
    comb : process(all)
    begin
        next_state <= state;
        next_count <= count;
        next_max   <= max;
        pulse      <= '0';

        case state is
            when Sidle =>
                if go = '1' and stop = '1' then
                    next_state <= Sprog;
                elsif go = '1' and stop = '0' then
                    next_state <= Sload;
                end if;

                next_count <= "011";

            when Sprog =>
                next_count <= std_logic_vector(unsigned(count) - 1);
                next_max   <= max(1 downto 0) & go;

                if count = "001" then
                    next_state <= Sidle;
                end if;

            when Sload =>
                next_state <= Swait;
				
                next_count <= max;

            when Swait =>
                pulse <= '1';
                next_count <= std_logic_vector(unsigned(count) - 1);

                if count = "001" or stop = '1' then
                    next_state <= Sidle;
                end if;
        end case;
    end process;

    regs : process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= Sidle;
                count <= (others => '0');
                max <= (others => '0');
            else
                state <= next_state;
                count <= next_count;
                max <= next_max;
            end if;
        end if;
    end process;
end architecture hlsm;
