library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8to1_dataflow_whenelse is
    port (
        in7_0  : in  std_logic_vector(7 downto 0);
        sel2_0 : in  std_logic_vector(2 downto 0);
        out0   : out std_logic
    );
end mux8to1_dataflow_whenelse;

architecture Dataflow of mux8to1_dataflow_whenelse is

begin
    out0 <= in7_0(0) when sel2_0 = "000" else
            in7_0(1) when sel2_0 = "001" else
            in7_0(2) when sel2_0 = "010" else
            in7_0(3) when sel2_0 = "011" else
            in7_0(4) when sel2_0 = "100" else
            in7_0(5) when sel2_0 = "101" else
            in7_0(6) when sel2_0 = "110" else
            in7_0(7);
    
end Dataflow;
