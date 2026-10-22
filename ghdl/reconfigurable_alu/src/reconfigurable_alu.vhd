library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reconfigurable_alu is
	port (
		nibble : in std_logic_vector(3 downto 0);
		din0   : in  std_logic_vector(15 downto 0);
		din1   : in  std_logic_vector(15 downto 0);
		ctrl   : in  std_logic_vector(2 downto 0);
		dout   : out std_logic_vector(15 downto 0)
	);
end reconfigurable_alu;

architecture Hierarchical of reconfigurable_alu is
	signal cin0  : std_logic;
	signal cout0 : std_logic;
	signal cin1  : std_logic;
	signal cout1 : std_logic;
	signal cin2  : std_logic;
	signal cout2 : std_logic;
	signal cin3  : std_logic;
	signal cout3 : std_logic;

	signal inc      : std_logic;
	signal ccontrol : std_logic_vector(3 downto 0);
begin
	inc <= '1' when std_match(ctrl, "0--") else
	       '0';

	with nibble select
		ccontrol <= "0000"                      when "0000",
					"000" & inc                 when "0001",
					"00" & inc & "0"            when "0010",
					"00" & cout0 & inc          when "0011",
					"0" & inc & "00"            when "0100",
					"0" & cout0 & "0" & inc     when "0101",
					"0" & cout1 & inc & "0"     when "0110",
					"0" & cout1 & cout0 & inc   when "0111",
					inc & "000"                 when "1000",
					cout0 & "00" & inc          when "1001",
					cout1 & "0" & inc & "0"     when "1010",
					cout1 & "0" & cout0 & inc   when "1011",
					cout2 & inc & "00"          when "1100",
					cout2 & cout0 & "0" & inc   when "1101",
					cout2 & cout1 & inc & "0"   when "1110",
					cout2 & cout1 & cout0 & inc when "1111",
					"XXXX"                      when others;

	cin0 <= ccontrol(0);
	cin1 <= ccontrol(1);
	cin2 <= ccontrol(2);
	cin3 <= ccontrol(3);

	alu0: entity work.alu
	generic map (
		WIDTH => 4
	)
	port map (
		enb  => nibble(0),
		cin  => cin0,
		din0 => din0(3 downto 0),
		din1 => din1(3 downto 0),
		dout => dout(3 downto 0),
		cout => cout0,
		ctrl => ctrl
	);

	alu1: entity work.alu
	generic map (
		WIDTH => 4
	)
	port map (
		enb  => nibble(1),
		cin  => cin1,
		din0 => din0(7 downto 4),
		din1 => din1(7 downto 4),
		dout => dout(7 downto 4),
		cout => cout1,
		ctrl => ctrl
	);

	alu2: entity work.alu
	generic map (
		WIDTH => 4
	)
	port map (
		enb  => nibble(2),
		cin  => cin2,
		din0 => din0(11 downto 8),
		din1 => din1(11 downto 8),
		dout => dout(11 downto 8),
		cout => cout2,
		ctrl => ctrl
	);

	alu3: entity work.alu
	generic map (
		WIDTH => 4
	)
	port map (
		enb  => nibble(3),
		cin  => cin3,
		din0 => din0(15 downto 12),
		din1 => din1(15 downto 12),
		dout => dout(15 downto 12),
		cout => cout3,
		ctrl => ctrl
	);
end Hierarchical;
