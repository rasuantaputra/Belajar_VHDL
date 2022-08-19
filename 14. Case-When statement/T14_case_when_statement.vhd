library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T14_case_when_statement is
end T14_case_when_statement;

architecture tutorial_14 of T14_case_when_statement is

    signal sig1 : unsigned(7 downto 0) := x"AA";
    signal sig2 : unsigned(7 downto 0) := x"BB";
    signal sig3 : unsigned(7 downto 0) := x"CC";
    signal sig4 : unsigned(7 downto 0) := x"DD";
    
    signal selector : unsigned( 1 downto 0) := (others => '0');
    -- kenapa ga bisa ?
    -- signal selector : unsigned( 1 downto 0);

    -- using if
    signal output1 : unsigned (7 downto 0);
    -- using case when
    signal output2 : unsigned (7 downto 0);
begin

    process is
    begin
        wait for 10 ps; 
        selector <= selector + 1;
        wait for 10 ps;
        selector <= selector + 1;
        wait for 10 ps;
        selector <= selector + "1";
        wait for 10 ps;
        selector <= selector + 1;
        wait for 10 ps;
        selector <= "UU";
        wait;
    end process;

    -- MUX using if-then-else
    process(selector, sig1, sig2, sig3, sig4) is
    begin
        if selector = "00" then
            output1 <= sig1;
        elsif selector = "01" then
            output1 <= sig2;
        elsif selector = "10" then
            output1 <= sig3;
        elsif selector ="11" then
            output1 <= sig4;
        else -- if selector 'U', 'X', '-', etc
            output1 <= (others => 'X');
        end if;
    end process;
    
    -- Equivalent MUX using a case statment
    process(selector, sig1, sig2, sig3, sig4) is
    begin
        case selector is        
            when "00" =>
                output2 <= sig1;
            when "01" =>
                output2 <= sig2;
            when "10" =>
                output2 <= sig3;
            when "11" =>
                output2 <= sig4;
            when others => -- if selector 'U', 'X', '--, etc
                output2 <= (others => 'X');        
        end case ;
    end process;
end tutorial_14; -- tutorial_14