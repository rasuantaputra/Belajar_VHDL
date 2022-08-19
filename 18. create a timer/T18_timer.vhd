library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T18_timer is
generic(clockFrequency : integer);
port (
    clk     : in std_logic;
    nRst    : in std_logic;
    seconds : inout integer;
    minutes : inout integer;
    hours   : inout integer
  ) ;
end T18_timer;

architecture rtl of T18_timer is
    -- signal for counting clock periods
    signal ticks : integer;
begin

    start_timer : process(clk) is
    begin
        if rising_edge(clk) then
            if nRst = '0' then
                ticks <= 0;
                seconds <= 0;
                minutes <= 0;
                hours <= 0;
            else
            if  ticks = clockFrequency - 1 then
                ticks <= 0;
                if seconds = 59 then
                    seconds <= 0;
                    if minutes = 59 then
                        minutes <= 0;
                        hours <= hours + 1;
                        if hours = 23 then
                            hours <= 0;
                            else
                            hours <= hours + 1;
                            end if;
                        else
                        minutes <= minutes + 1;
                        end if;
                    else
                    seconds <= seconds + 1;
                    end if;
                else
                ticks <= ticks + 1;
            end if;
        end if;
        end if;
    end process ; -- start_timer
end rtl ; -- rtl