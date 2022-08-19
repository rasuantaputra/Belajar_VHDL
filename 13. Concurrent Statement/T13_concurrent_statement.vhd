library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T13_concurrent_statement is
end T13_concurrent_statement;

architecture tutorial_13 of T13_concurrent_statement is

    signal uns  : unsigned(5 downto 0) := (others => '0');
    signal mul1 : unsigned(7 downto 0);
    signal mul2 : unsigned(7 downto 0);
    signal mul3 : unsigned(7 downto 0);
begin

    process is
    begin
        uns <= uns + 1;
        wait for 10 ps;
    end process;

    -- process multiplying uns by 4
    process is
    begin
        mul1 <= uns & "00";
        wait on uns;
    end process;

    -- equivalent process using sensitivity list 
    process(uns) is
    begin
        mul2 <= uns & "00";
    end process;

    -- equivalent process using concurrent statement
    -- maksudnya kita bisa melakukan operasi signal tanpa perlu didalam "process"
    mul3 <= uns & "00"; 
    

end tutorial_13 ; -- tutorial_13

