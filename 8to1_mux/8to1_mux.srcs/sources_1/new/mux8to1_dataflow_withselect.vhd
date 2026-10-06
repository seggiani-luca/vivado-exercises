library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8to1_dataflow_withselect is
    port (
        in7_0  : in  std_logic_vector(7 downto 0);
        sel2_0 : in  std_logic_vector(2 downto 0);
        out0   : out std_logic
    );
end mux8to1_dataflow_withselect;

architecture Dataflow of mux8to1_dataflow_withselect is

begin
    with sel2_0 select
        out0 <= in7_0(0) when "000",
                in7_0(1) when "001",
                in7_0(2) when "010",
                in7_0(3) when "011",
                in7_0(4) when "100",
                in7_0(5) when "101",
                in7_0(6) when "110",
                in7_0(7) when "111",
                'X'      when others;
    
end Dataflow;
