library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T17_create_a_clocked_process is
end T17_create_a_clocked_process;

architecture tutorial_17 of T17_create_a_clocked_process is

    constant clock_frequency : integer := 100e6; -- 100 MHz
    -- "time" data type for specifying time value
    constant clock_period : time := 1000 ms / clock_frequency;
    
    signal clock : std_logic := '1';
    signal negative_reset : std_logic := '0';
    signal input : std_logic :='0';
    signal output : std_logic;

begin

    modul_flipflop : entity work.T17_flipflop(rtl)
    port map(
        clk    =>clock,
        nRst   => negative_reset,
        input  => input,
        output => output
    );

    -- Process for generating the clock
    clock <= not clock after clock_period/2 ;

    -- testbench sequence (untuk tes perilaku flipflop)
    process is
    begin
        -- Take the DUT out of reset
        negative_reset <= '1';

        wait for 20 ns;
        input <= '1';
        wait for 22 ns;
        input <= '0';
        wait for 6 ns;
        input <= '1';
        wait for 20 ns;

        negative_reset <= '0';

        wait;
    end process;
end tutorial_17 ; -- tutorial_17