library ieee;
use ieee.std_logic_1164.all;

entity T11_std_logic_vector is
end entity;

architecture tutorial_11 of T11_std_logic_vector is
    -- create 1 byte signal array (8 bit) with start index from 7 to 0
    signal sig1 : std_logic_vector(7 downto 0);
    -- "others" keyword for add 0 value to each index
    signal sig2 : std_logic_vector(7 downto 0) := (others => '0');
    -- "others" keyword for add 1 value to each index
    signal sig3 : std_logic_vector(7 downto 0) := (others => '1');
    -- "x" mean hexadecimal
    signal sig4 : std_logic_vector(7 downto 0) := x"AA";
    -- -- create 1 byte signal array (8 bit) with start index from 0 to 7
    signal sig5 : std_logic_vector(0 to 7) := "10101010";
    signal sig6 : std_logic_vector(7 downto 0) := "00000001";
    -- try by my self
    signal sig7 : std_logic_vector(7 downto 5) := "011";
begin

    -- shift register
    process is
    begin
        wait for 10 ps;
        -- "'left" keyword for get the index value at most left (7)
        -- "'right" keyword for get the index value at most right (0)
        for i in sig6'left downto sig6'right + 1 loop
            sig6(i) <= sig6(i-1);
        end loop;

        sig6(sig6'right) <= sig6(sig6'left);
    end process;
end tutorial_11;