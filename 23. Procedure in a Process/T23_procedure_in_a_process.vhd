library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T23_procedure_in_a_process is
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
end T23_procedure_in_a_process;

architecture rtl of T23_procedure_in_a_process is

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
    
    -- enumerate type declaration and state signal declaration
    type t_state is (northNext, startNorth, north, stopNorth, westNext, startWest, west, stopWest);
    signal state : t_state;

    signal counter : integer range 0 to clockFrequency * 60;

begin

    startFinitemachine : process(clk)

    -- make procedure in a process
    procedure changeState(toState : t_state; minutes : integer := 0; seconds : integer := 0) is
        variable total_second : integer;
        variable clock_cycles : integer;
    begin
        total_second := seconds + minutes * 60;
        clock_cycles := total_second * clockFrequency - 1;

        if counter = clock_cycles then
            counter <= 0;
            state <= toState;
        end if;        
    end procedure;

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
                        changeState(startNorth, seconds => 5);

                    -- startNorth = red yellow                        
                    when startNorth =>
                        northRed    <= '1';
                        northYellow <= '1';
                        westRed     <= '1';

                        -- inf 5 seconds have passed
                        changeState(north, seconds => 5);

                    -- north = green
                    when north =>
                        northGreen  <= '1';
                        westRed     <= '1';

                        -- inf 1 minutes have passed
                        changeState(stopNorth, minutes => 1);

                    -- stopNorth = yellow
                    when stopNorth =>
                        northYellow <= '1';
                        westRed     <= '1';
                        
                        -- inf 5 seconds have passed
                        changeState(westNext, seconds => 5);

                    -- westNext = red (red all direction)
                    when westNext =>
                        northRed    <= '1';
                        westRed     <= '1';
                        
                        -- inf 5 seconds have passed
                        changeState(startWest, seconds => 5);

                    -- startwest = red yellow
                    when startWest =>
                        northRed    <= '1';
                        westRed     <= '1';
                        westYellow  <= '1';
                        
                        -- inf 5 seconds have passed
                        changeState(west, seconds => 5);

                    -- west = green
                    when west =>
                        northRed    <= '1';
                        westGreen   <= '1';
                        
                        -- inf 1 minutes have passed
                        changeState(stopWest, minutes => 1);

                    -- stopwest = yellow
                    when stopWest =>
                        northRed    <= '1';
                        westYellow  <= '1';
                        
                        -- inf 5 seconds have passed
                        changeState(northNext, seconds => 5);
                end case;
            end if;
        end if;        
    end process;
end architecture;