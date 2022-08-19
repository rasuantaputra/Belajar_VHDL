library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T19_timer_using_procedur_sim is
end T19_timer_using_procedur_sim;

architecture tutorial_19 of T19_timer_using_procedur_sim is

    constant clock_frequency : integer := 10; -- 10 Mhz
    constant clock_period : time := 1000 ms / clock_frequency;

    signal clock : std_logic := '1';
    signal negative_reset : std_logic := '0';

    signal detik    : integer;
    signal menit    : integer;
    signal jam      : integer;

begin

    -- the device under test (DUT)
    timer_modul : entity work.T19_timer_using_procedur(rtl)
    generic map(clockFrequency => clock_frequency)
    port map(
        clk => clock,
        nRst => negative_reset,
        seconds => detik,
        minutes => menit,
        hours => jam
    );

    -- generating clock
    clock <= not clock after clock_period/2;

    process_begin : process is
    begin
        wait until rising_edge(clock);
        wait until rising_edge(clock);

        negative_reset <= '1';

        wait;   
    end process ; -- testbench_seq
end tutorial_19 ; -- tutorial_19