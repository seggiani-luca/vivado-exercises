library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hamming_distance is
    port (
        a7_0   : in std_logic_vector(7 downto 0);
        b7_0   : in std_logic_vector(7 downto 0);
        out3_0 : out std_logic_vector(3 downto 0)
    );
end hamming_distance;

architecture Dataflow of hamming_distance is
    signal diff7_0   : std_logic_vector(7 downto 0);
    
    signal p00sum1_0 : std_logic_vector(1 downto 0);
    signal p01sum1_0 : std_logic_vector(1 downto 0);
    signal p02sum1_0 : std_logic_vector(1 downto 0);
    signal p03sum1_0 : std_logic_vector(1 downto 0);
    
    signal p10sum2_0 : std_logic_vector(2 downto 0);
    signal p11sum2_0 : std_logic_vector(2 downto 0);
begin
    diff7_0 <= a7_0 xor b7_0;
    
    p00sum1_0 <= std_logic_vector(
        resize(unsigned'('0' & diff7_0(7)), 2) +
        resize(unsigned'('0' & diff7_0(6)), 2)
    );
    p01sum1_0 <= std_logic_vector(
        resize(unsigned'('0' & diff7_0(5)), 2) +
        resize(unsigned'('0' & diff7_0(4)), 2)
    );
    p02sum1_0 <= std_logic_vector(
        resize(unsigned'('0' & diff7_0(3)), 2) +
        resize(unsigned'('0' & diff7_0(2)), 2)
    );
    p03sum1_0 <= std_logic_vector(
        resize(unsigned'('0' & diff7_0(1)), 2) +
        resize(unsigned'('0' & diff7_0(0)), 2)
    );
     
    p10sum2_0 <= std_logic_vector(unsigned('0' & p00sum1_0) + unsigned('0' & p01sum1_0));
    p11sum2_0 <= std_logic_vector(unsigned('0' & p02sum1_0) + unsigned('0' & p03sum1_0));
    
    out3_0 <= std_logic_vector(unsigned('0' & p10sum2_0) + unsigned('0' & p11sum2_0));
end Dataflow;
