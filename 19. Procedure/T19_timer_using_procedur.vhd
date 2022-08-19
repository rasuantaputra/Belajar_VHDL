library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T19_timer_using_procedur is
  generic(clockFrequency : integer);
  port (
    clk     : in std_logic;
    nRst    : in std_logic;
    seconds : inout integer;
    minutes : inout integer;
    hours   : inout integer
  ) ;
end T19_timer_using_procedur;

architecture rtl of T19_timer_using_procedur is
  -- signal for counting clock period
  signal ticks : integer;
  -- incrementWrap(counter, wrapValue, enable, wraped){}
  procedure incrementWrap(signal counter      : inout integer;
                          constant wrapValue  : in integer;
                          constant enable     : in boolean;
                          variable wraped     : out boolean) is
  begin
    if enable then
      if counter = wrapValue - 1 then
        wraped := true;
        counter <= 0;
      else
        wraped := false;
        counter <= counter + 1;
      end if ;
    end if; 
  end procedure;

begin

  timer_using_procedure : process(clk) is
    variable flag : boolean;
  begin
    if rising_edge(clk) then
      -- for reseting when negative reset active
      if nRst = '0'then
        ticks <= 0;
        seconds <= 0;
        minutes <= 0;
        hours <= 0;
      else
        -- cascade counters
        incrementWrap(ticks, clockFrequency, true, flag);
        incrementWrap(seconds, 60, flag, flag);
        incrementWrap(minutes, 60, flag, flag);
        incrementWrap(hours, 24, flag, flag);
      end if;
    end if;   
  end process;
end rtl ; -- rtl