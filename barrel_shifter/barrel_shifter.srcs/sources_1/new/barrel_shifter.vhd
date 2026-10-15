library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity barrel_shifter is
    port(
        in7_0  : in  std_logic_vector(7 downto 0);
        lar1_0 : in  std_logic_vector(1 downto 0);
        amt2_0 : in  std_logic_vector(2 downto 0);
        out7_0 : out std_logic_vector(7 downto 0)
    );
end barrel_shifter;

architecture Dataflow of barrel_shifter is
    signal shift4_7_0 : std_logic_vector(7 downto 0);
    signal shift2_7_0 : std_logic_vector(7 downto 0);
    signal shift1_7_0 : std_logic_vector(7 downto 0);

    signal int1_7_0 : std_logic_vector(7 downto 0);
    signal int0_7_0 : std_logic_vector(7 downto 0);
begin
    with lar1_0 select
        shift4_7_0 <= "0000" & in7_0(7 downto 4)                         when "00",
                      (7 downto 4 => in7_0(7)) & in7_0(7 downto 4)       when "01",
                      in7_0(3 downto 0) & in7_0(7 downto 4)              when "10",
                      "XXXXXXXX"                                         when others;

    with lar1_0 select
        shift2_7_0 <= "00" & int1_7_0(7 downto 2)                        when "00",
                      (7 downto 6 => int1_7_0(7)) & int1_7_0(7 downto 2) when "01",
                      int1_7_0(1 downto 0) & int1_7_0(7 downto 2)        when "10",
                      "XXXXXXXX"                                         when others;
    
    with lar1_0 select
        shift1_7_0 <= '0' & int0_7_0(7 downto 1)                         when "00",
                      int0_7_0(7) & int0_7_0(7 downto 1)                 when "01",
                      int0_7_0(0) & int0_7_0(7 downto 1)                 when "10",
                      "XXXXXXXX"                                         when others;

    -- mux 2
    int1_7_0 <= shift4_7_0 when amt2_0(2) = '1' else
                in7_0;
    -- mux 1
    int0_7_0 <= shift2_7_0 when amt2_0(1) = '1' else
                int1_7_0; 
    -- mux 0
    out7_0   <= shift1_7_0 when amt2_0(0) = '1' else
                int0_7_0;

end Dataflow;
