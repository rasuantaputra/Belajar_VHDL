library ieee;
use ieee.std_logic_1164.all;

entity T10_std_logic is
end T10_std_logic;

architecture tutorial_10 of T10_std_logic is
    signal signal1 : std_logic := '0';
    signal signal2 : std_logic;
    signal signal3 : std_logic;
begin
      
    process is
    begin

        wait for 10 ps;
        signal1 <= not signal1;    
    end process;

    -- Driver A
    process is 
    begin
        signal2 <= 'Z';
        signal3 <= '0';
        wait;
    end process;

    -- Driver B
    process(signal1) is
    begin
        if signal1 = '0' then
            signal2 <= 'Z';
            signal3 <= 'Z';
        else
            signal2 <= '1';
            signal3 <= '1';            
        end if ;
    end process;        
end tutorial_10;

-- Note of std_logic
-- '1' - Binary 1
-- '0' - Binary 0
-- 'U' - Uninitialized => ????
-- 'X' - Unknown / multiple drivers => ????
-- 'Z' - High impedance / no driver => driver is disconected
-- 'H' - Weak 1 / pullup => useful for pull up logic for interfaces (I2C, SPI, ect)
-- 'L' - Weak 0 / pulldown => useful for pull down logic for interfaces (I2C, SPI, ect)
-- 'W' - Weak signal, can't tell if 1 or 0  => voltage to weak to tell the real value is
-- '-' - Don't care (used in comparisons) => ????