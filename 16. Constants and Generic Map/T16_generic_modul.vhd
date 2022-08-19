library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- The purpose of this tutorial is to make variables can change from outside
entity T16_generic_modul is
-- This syntax makes variables accessible and changeable outside
-- nama variable boleh kreatif
generic(data_width : integer);
port(
    -- input signal
    signal1 : in unsigned(data_width - 1 downto 0);
    signal2 : in unsigned(data_width - 1 downto 0);
    signal3 : in unsigned(data_width - 1 downto 0);
    signal4 : in unsigned(data_width - 1 downto 0);

    -- selector
    selector : in signed(1 downto 0);

    -- output signal
    output : out unsigned(data_width - 1 downto 0)
);
end T16_generic_modul;

architecture rtl of T16_generic_modul is
begin

    process(signal1, signal2, signal3, signal4, selector) is
    begin

        case selector is
        
            when "00" =>
                output <= signal1;
            when "01" =>
                output <= signal2;
            when "10" =>
                output <= signal3;
            when "11" =>
                output <= signal4;
            when others => --'U','X', '-', etc
                output <= (others => 'X');
        
        end case ;
    end process;

end rtl; -- rtl