library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T21_fuction is
    generic(clockFrequency : integer);
    port (
        clk     : in std_logic;
        nRst    : in std_logic;

        northRed    : out std_logic;
        northYellow : out std_logic;
        northGreen  : out std_logic;

        westRed     : out std_logic;
        westYellow  : out std_logic;
        westGreen   : out std_logic
    );
end T21_fuction;

architecture rtl of T21_fuction is

-- ###########################################################################################################
-- finite state machine of traffic lights :

-- startNorth -> north -> stopNorth
    -- ^                      |
    -- |                      v
-- northNext              westNext
    -- ^                      |
    -- |                      v
-- stopWest <-  west   <- startWest

-- northNext = red
-- startNorth = red yellow
-- north = green
-- stopNorth = yellow
-- westNext = red

-- westNext = red
-- startwest = red yellow
-- west = green
-- stopwest = yellow
-- northtNext = red
-- ###########################################################################################################
    -- Function for calculating the number of clock cycles in min/sec
    function counterVal(minutes : integer := 0; seconds : integer := 0) return integer is
        variable total_second : integer;    
    begin
        total_second := seconds + minutes * 60;
        return total_second * clockFrequency - 1;       
    end function;

    -- enumerate type declaration and state signal declaration
    type t_state is (northNext, startNorth, north, stopNorth, westNext, startWest, west, stopWest);
    signal state : t_state;

    signal counter : integer range 0 to clockFrequency * 60;

begin

    startFinitemachine : process(clk)
    begin
        if rising_edge(clk) then
            if nRst = '0' then
                -- reset value
                state <= northNext;
                counter <= 0;

                northRed    <= '1';
                northYellow <= '0';
                northGreen  <= '0';
        
                westRed     <= '1';
                westYellow  <= '0';
                westGreen   <= '0';
            else
                -- default condition
                northRed    <= '0';
                northYellow <= '0';
                northGreen  <= '0';
        
                westRed     <= '0';
                westYellow  <= '0';
                westGreen   <= '0';

                counter <= counter + 1;

                case state is
                    -- northNext = red (red in all direction)                    
                    when northNext =>
                        northRed    <= '1';
                        northRed    <= '1';
                    
                        -- inf 5 seconds have passed
                        if counter = counterVal(seconds => 5) then
                            counter <= 0;
                            state <= startNorth;
                        end if;

                    -- startNorth = red yellow                        
                    when startNorth =>
                        northRed    <= '1';
                        northYellow <= '1';
                        westRed     <= '1';

                        -- inf 5 seconds have passed
                        if counter = counterVal(seconds => 5) then
                            counter <= 0;
                            state <= north;
                        end if;

                    -- north = green
                    when north =>
                        northGreen  <= '1';
                        westRed     <= '1';

                        -- inf 1 minutes have passed
                        if counter = counterVal(minutes => 1) then
                            counter <= 0;
                            state <= stopNorth;
                        end if;

                    -- stopNorth = yellow
                    when stopNorth =>
                        northYellow <= '1';
                        westRed     <= '1';
                        
                        -- inf 5 seconds have passed
                        if counter = counterVal(seconds => 5)then
                            counter <= 0;
                            state <= westNext;
                        end if;

                    -- westNext = red (red all direction)
                    when westNext =>
                        northRed    <= '1';
                        westRed     <= '1';
                        
                        -- inf 5 seconds have passed
                        if counter = counterVal(seconds => 5) then
                            counter <= 0;
                            state <= startWest;
                        end if;

                    -- startwest = red yellow
                    when startWest =>
                        northRed    <= '1';
                        westRed     <= '1';
                        westYellow  <= '1';
                        
                        -- inf 5 seconds have passed
                        if counter = counterVal(seconds => 5) then
                            counter <= 0;
                            state <= west;
                        end if;

                    -- west = green
                    when west =>
                        northRed    <= '1';
                        westGreen   <= '1';
                        
                        -- inf 1 minutes have passed
                        if counter = counterVal(minutes => 1) then
                            counter <= 0;
                            state <= stopWest;
                        end if;

                    -- stopwest = yellow
                    when stopWest =>
                        northRed    <= '1';
                        westYellow  <= '1';
                        
                        -- inf 5 seconds have passed
                        if counter = clockFrequency * 5 - 1 then
                            counter <= 0;
                            state <= northNext;
                        end if;
                end case;
            end if;
        end if;        
    end process;
end architecture;