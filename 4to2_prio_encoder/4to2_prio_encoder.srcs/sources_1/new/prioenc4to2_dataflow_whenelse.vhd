library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity prioenc4to2_dataflow_whenelse is
    port (
        req3_0  : in  std_logic_vector(3 downto 0);
        code1_0 : out std_logic_vector(1 downto 0);
        act0    : out std_logic
    );
end prioenc4to2_dataflow_whenelse;

architecture Dataflow of prioenc4to2_dataflow_whenelse is

begin
    code1_0 <= "11" when req3_0(3) = '1' else
               "10" when req3_0(2) = '1' else
               "01" when req3_0(1) = '1' else
               "00";
    
    act0 <= '0' when req3_0 = "0000" else '1';

end Dataflow;
