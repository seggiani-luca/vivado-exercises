library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity diff_comp is
    port (
        a7_0   : in std_logic_vector(7 downto 0);
        b7_0   : in std_logic_vector(7 downto 0);
        out7_0 : out std_logic_vector(7 downto 0)
    );
end diff_comp;

architecture Dataflow of diff_comp is
begin
    out7_0 <= a7_0 xor b7_0;
end Dataflow;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder is
    port (
        a : in  std_logic;
        b : in  std_logic;
        r : out std_logic;
        cout : out std_logic
    );
end half_adder;

architecture Dataflow of half_adder is
begin
    r <= a xor b;
    cout <= a and b;
end Dataflow;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    port (
        a : in std_logic;
        b : in std_logic;
        cin : in std_logic;
        r : out std_logic;
        cout : out std_logic
    );
end full_adder;

architecture Dataflow of full_adder is
    signal r0 : std_logic;
    signal cout0 : std_logic;
    signal cout1 : std_logic;
begin
    half_adder0 : entity work.half_adder
    port map (
        a => a,
        b => b,
        r => r0,
        cout => cout0
    );
    
    half_adder1 : entity work.half_adder
    port map (
        a => r0,
        b => cin,
        r => r,
        cout => cout1
    );
    
    cout <= cout0 or cout1;
end Dataflow;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity add2_2 is
    port (
        a0 : in std_logic;
        b0 : in std_logic;
        r1_0 : out std_logic_vector(1 downto 0)
    );
end add2_2;

architecture Structural of add2_2 is
begin
    full_adder0 : entity work.full_adder
    port map (
        cin => '0',
        a => a0,
        b => b0,
        r => r1_0(0),
        cout => r1_0(1)
    );
end Structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity add4_3 is
    port (
        a1_0 : in std_logic_vector(1 downto 0);
        b1_0 : in std_logic_vector(1 downto 0);
        r2_0 : out std_logic_vector(2 downto 0)
    );
end add4_3;

architecture Structural of add4_3 is
    signal cout0 : std_logic;
begin
    full_adder0 : entity work.full_adder
    port map (
        cin => '0',
        a => a1_0(0),
        b => b1_0(0),
        r => r2_0(0),
        cout => cout0
    );
    full_adder1 : entity work.full_adder
    port map (
        cin => cout0,
        a => a1_0(1),
        b => b1_0(1),
        r => r2_0(1),
        cout => r2_0(2)
    );
end Structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity add6_4 is
    port (
        a2_0 : in std_logic_vector(2 downto 0);
        b2_0 : in std_logic_vector(2 downto 0);
        r3_0 : out std_logic_vector(3 downto 0)
    );
end add6_4;

architecture Structural of add6_4 is
    signal cout0 : std_logic;
    signal cout1 : std_logic;
begin
    full_adder0 : entity work.full_adder
    port map (
        cin => '0',
        a => a2_0(0),
        b => b2_0(0),
        r => r3_0(0),
        cout => cout0
    );
    full_adder1 : entity work.full_adder
    port map (
        cin => cout0,
        a => a2_0(1),
        b => b2_0(1),
        r => r3_0(1),
        cout => cout1
    );
    full_adder2 : entity work.full_adder
    port map (
        cin => cout1,
        a => a2_0(2),
        b => b2_0(2),
        r => r3_0(2),
        cout => r3_0(3)
    );
end Structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hamming_distance_structural is
    port (
        a7_0   : in std_logic_vector(7 downto 0);
        b7_0   : in std_logic_vector(7 downto 0);
        out3_0 : out std_logic_vector(3 downto 0)
    );
end hamming_distance_structural;

architecture Structural of hamming_distance_structural is
    signal diff7_0   : std_logic_vector(7 downto 0);
    
    signal p00sum1_0 : std_logic_vector(1 downto 0);
    signal p01sum1_0 : std_logic_vector(1 downto 0);
    signal p02sum1_0 : std_logic_vector(1 downto 0);
    signal p03sum1_0 : std_logic_vector(1 downto 0);
    
    signal p10sum2_0 : std_logic_vector(2 downto 0);
    signal p11sum2_0 : std_logic_vector(2 downto 0);
begin

    diff_comp: entity work.diff_comp
    port map (
        a7_0 => a7_0,
        b7_0  => b7_0,
        out7_0  => diff7_0
    );
    
    p00_add2_2 : entity work.add2_2
    port map (
        a0 => diff7_0(0),
        b0 => diff7_0(1),
        r1_0 => p00sum1_0
    );
    p01_add2_2 : entity work.add2_2
    port map (
        a0 => diff7_0(2),
        b0 => diff7_0(3),
        r1_0 => p01sum1_0
    );
    p02_add2_2 : entity work.add2_2
    port map (
        a0 => diff7_0(4),
        b0 => diff7_0(5),
        r1_0 => p02sum1_0
    );
    p03_add2_2 : entity work.add2_2
    port map (
        a0 => diff7_0(6),
        b0 => diff7_0(7),
        r1_0 => p03sum1_0
    );
    
    p10_add4_3 : entity work.add4_3
    port map (
        a1_0 => p00sum1_0,
        b1_0 => p01sum1_0,
        r2_0 => p10sum2_0
    );
    p11_add4_3 : entity work.add4_3
    port map (
        a1_0 => p02sum1_0,
        b1_0 => p03sum1_0,
        r2_0 => p11sum2_0
    );
    
    p20_add_6_4 : entity work.add6_4
    port map(
        a2_0 => p10sum2_0,
        b2_0 => p11sum2_0,
        r3_0 => out3_0
    );

end Structural;
