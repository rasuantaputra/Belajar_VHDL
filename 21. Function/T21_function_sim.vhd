library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T21_function_sim is
end T21_function_sim;

architecture tutorial_21 of T21_function_sim is

    constant clock_frequency : integer := 100; --100 Hz
    constant clock_period : time := 1000 ms / clock_frequency;

    signal clock : std_logic := '1';
    signal negative_reset : std_logic := '0';

    signal utara_merah     : std_logic;
    signal utara_kuning    : std_logic;
    signal utara_hijau     : std_logic;

    signal barat_merah     : std_logic;
    signal barat_kuning    : std_logic;
    signal barat_hijau     : std_logic;
begin

    trafficLights : entity work.T21_fuction(rtl)
    generic map(clockFrequency => clock_frequency)
    port map (
        clk => clock,
        nRst => negative_reset,
        
        northRed    => utara_merah,
        northYellow => utara_kuning,
        northGreen  => utara_hijau,

        westRed     => barat_merah,
        westYellow  => barat_kuning,
        westGreen   => barat_hijau
    );

    -- proces generating clock 
    clock <= not clock after clock_period / 2;

    -- test bench sequence
    process is
    begin
        wait until rising_edge(clock);
        wait until rising_edge(clock);

        negative_reset <='1';
        wait;
    end process;
    

end architecture;