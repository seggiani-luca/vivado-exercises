-- ------------------------------------------------------------
-- MODULE 1: Binary to Gray
-- ------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bin_to_gray is
    generic (
        WIDTH : positive := 8
    );
    port (
        bin  : in std_logic_vector(WIDTH-1 downto 0);
        gout : out std_logic_vector(WIDTH-1 downto 0)
    );
end bin_to_gray;

architecture Dataflow of bin_to_gray is
begin
    gout <= bin xor ('0' & bin(WIDTH-1 downto 1));
end Dataflow;

-- ------------------------------------------------------------
-- MODULE 2: Gray to Binary
-- ------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gray_to_bin is
    generic (
        WIDTH : positive := 8
    );
    port (
        gin  : in std_logic_vector(WIDTH-1 downto 0);
        bout : out std_logic_vector(WIDTH-1 downto 0)
    );
end gray_to_bin;

architecture Dataflow of gray_to_bin is
    signal bin : std_logic_vector(WIDTH-1 downto 0);
begin
    bin(WIDTH-1) <= gin(WIDTH-1);
    
    gen: for i in WIDTH-2 downto 0 generate
        bin(i) <= gin(i) xor bin(i + 1);
    end generate;
    
    bout <= bin;
end Dataflow;

-- ------------------------------------------------------------
-- MODULE 3: Gray code incrementer
-- ------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity gray_code_inc is
    generic (
        WIDTH : positive := 8
    );
    port (
        gin  : in std_logic_vector(WIDTH-1 downto 0);
        gout : out std_logic_vector(WIDTH-1 downto 0)
    );
end gray_code_inc;

architecture Dataflow of gray_code_inc is
    signal bus0 : std_logic_vector(WIDTH-1 DOWNTO 0);
    signal bus1 : std_logic_vector(WIDTH-1 DOWNTO 0);
begin
    gtob: entity work.gray_to_bin
    generic map (
        WIDTH => WIDTH
    )
    port map (
        gin  => gin,
        bout => bus0
    );

    bus1 <= std_logic_vector(unsigned(bus0) + 1);

    btog: entity work.bin_to_gray
    generic map (
        WIDTH => WIDTH
    )
    port map (
        bin  => bus1,
        gout => gout
    );

end Dataflow;
