-- 2to1 mux
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2to1_dataflow is
    port (
        in1_0 : in  std_logic_vector(1 downto 0);
        sel0  : in  std_logic;
        out0  : out std_logic
    );
end mux2to1_dataflow;

architecture Dataflow of mux2to1_dataflow is

begin
    out0 <= (in1_0(0) and not sel0) or (in1_0(1) and sel0); 

end Dataflow;

-- 4to1 mux
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4to1_structural is
    port (
        in3_0  : in  std_logic_vector(3 downto 0);
        sel1_0 : in  std_logic_vector(1 downto 0);
        out0   : out std_logic
    );
end mux4to1_structural;

architecture Structural of mux4to1_structural is
    signal sout1_0 : std_logic_vector(1 downto 0);
begin
    mux2to1_1: entity work.mux2to1_dataflow
    port map (
        in1_0 => in3_0(3 downto 2),
        sel0  => sel1_0(0),
        out0  => sout1_0(1)
    );
    
    mux2to1_0: entity work.mux2to1_dataflow
    port map (
        in1_0 => in3_0(1 downto 0),
        sel0  => sel1_0(0),
        out0  => sout1_0(0)
    );

    mux2to1_f: entity work.mux2to1_dataflow
    port map (
        in1_0 => sout1_0,
        sel0  => sel1_0(1),
        out0  => out0
    );

end Structural;

-- 8to1 mux
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8to1_structural is
    port (
        in7_0  : in  std_logic_vector(7 downto 0);
        sel2_0 : in  std_logic_vector(2 downto 0);
        out0   : out std_logic
    );
end mux8to1_structural;

architecture Structural of mux8to1_structural is
    signal sout1_0 : std_logic_vector(1 downto 0);
begin
    mux4to1_1: entity work.mux4to1_structural
    port map (
        in3_0  => in7_0(7 downto 4),
        sel1_0 => sel2_0(1 downto 0),
        out0   => sout1_0(1)
    );
    
    mux4to1_0: entity work.mux4to1_structural
    port map (
        in3_0  => in7_0(3 downto 0),
        sel1_0 => sel2_0(1 downto 0),
        out0   => sout1_0(0)
    );

    mux2to1_f: entity work.mux2to1_dataflow
    port map (
        in1_0 => sout1_0,
        sel0  => sel2_0(2),
        out0  => out0
    );

end Structural;
