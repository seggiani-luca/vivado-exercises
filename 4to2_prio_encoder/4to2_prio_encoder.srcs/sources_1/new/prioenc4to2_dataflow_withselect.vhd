library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity prioenc4to2_dataflow_withselect is
    port (
        req3_0  : in  std_logic_vector(3 downto 0);
        code1_0 : out std_logic_vector(1 downto 0);
        act0    : out std_logic
    );
end prioenc4to2_dataflow_withselect;

architecture Dataflow of prioenc4to2_dataflow_withselect is

begin
    with req3_0 select
        code1_0 <= "00" when "0000",
                   "00" when "0001",
                   "01" when "0010" | "0011",
                   "10" when "0100" | "0101" | "0110" | "0111",
                   "11" when others;
    with req3_0 select
        act0 <= '0' when "0000",
                '1' when others;

end Dataflow;
