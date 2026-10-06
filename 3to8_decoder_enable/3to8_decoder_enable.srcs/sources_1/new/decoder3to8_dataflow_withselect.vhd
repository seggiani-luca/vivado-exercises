library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder3to8_dataflow_withselect is
    port (
        in2_0  : in  std_logic_vector(2 downto 0);
        out7_0 : out std_logic_vector(7 downto 0);
        enb0   : in  std_logic
    );
end decoder3to8_dataflow_withselect;

architecture Dataflow of decoder3to8_dataflow_withselect is

begin
    with in2_0 select
        out7_0 <= (0 => enb0, others => '0') when "000",
                  (1 => enb0, others => '0') when "001",
                  (2 => enb0, others => '0') when "010",
                  (3 => enb0, others => '0') when "011",
                  (4 => enb0, others => '0') when "100",
                  (5 => enb0, others => '0') when "101",
                  (6 => enb0, others => '0') when "110",
                  (7 => enb0, others => '0') when "111",
                  "XXXXXXXX"                 when others;
    
end Dataflow;