library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder3to8_dataflow_whenelse is
    port (
        in2_0  : in  std_logic_vector(2 downto 0);
        out7_0 : out std_logic_vector(7 downto 0);
        enb0   : in  std_logic
    );
end decoder3to8_dataflow_whenelse;

architecture Dataflow of decoder3to8_dataflow_whenelse is

begin
    out7_0 <= (0 => enb0, others => '0') when in2_0 = "000" else
              (1 => enb0, others => '0') when in2_0 = "001" else
              (2 => enb0, others => '0') when in2_0 = "010" else
              (3 => enb0, others => '0') when in2_0 = "011" else
              (4 => enb0, others => '0') when in2_0 = "100" else
              (5 => enb0, others => '0') when in2_0 = "101" else
              (6 => enb0, others => '0') when in2_0 = "110" else
              (7 => enb0, others => '0');

end Dataflow;