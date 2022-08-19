library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T17_flipflop is
  port (
    clk     : in std_logic;
    nRst    : in std_logic;
    input   : in std_logic;
    output  : out std_logic 
  ) ;
end T17_flipflop;

architecture rtl of T17_flipflop is
begin

    -- Flip-flop with synchronized reset
    flipflop : process( clk ) is
    begin

        if rising_edge(clk) then
            if nRst = '0' then
                output <= '0';
            else
                output <= input;                
            end if ;
        end if;        
    end process ; -- flipflop

end rtl ; -- rtl