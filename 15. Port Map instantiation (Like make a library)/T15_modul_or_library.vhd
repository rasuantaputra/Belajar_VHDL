library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- entity name must be same with file name !
entity T15_modul_or_library is
port (
    -- input
    signal1 : in unsigned(7 downto 0);
    signal2 : in unsigned(7 downto 0);
    signal3 : in unsigned(7 downto 0);
    signal4 : in unsigned(7 downto 0);
    
    selector : in unsigned(1 downto 0);

    -- output
    output : out unsigned(7 downto 0) -- dont need ";" here
);
end T15_modul_or_library;

-- register transfer level (RTL)
architecture rtl of T15_modul_or_library is
begin

    process(signal1, signal2, signal3, signal4, selector) is
    begin
        case selector is
        
            when "00" =>
                output <= signal1;
            when "01" =>
                output<= signal2;
            when "10" =>
                output <= signal3;
            when "11" =>
                output <= signal4;
            when others => -- if selector 'U', 'X', '-', etc
                output <= (others => 'X');
        end case ;   
    end process; -- 
end rtl; -- rtl