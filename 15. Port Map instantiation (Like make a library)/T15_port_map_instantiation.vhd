-- This tutorial same as made external modul/library in C++, python, etc
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T15_port_map_instantiation is
end T15_port_map_instantiation;

architecture tutorial_15 of T15_port_map_instantiation is
    -- don't forget ":=" !!!
    signal signal_1 : unsigned(7 downto 0) := x"AA";
    signal signal_2 : unsigned(7 downto 0) := x"BB";
    signal signal_3 : unsigned(7 downto 0) := x"CC";
    signal signal_4 : unsigned(7 downto 0) := x"DD";

    signal mux_selector : unsigned(1 downto 0) := (others => '0');

    signal output : unsigned(7 downto 0);
begin
    -- An instance of T15_modul_tutorial_as_library with architectur rtl
    -- nama "i_mux1" boleh bebas
    -- nama "work" adalah tempat (library) dimana modul T15_modul_tutorial_as_library di simpan (dan di compile)
    i_mux : entity work.T15_modul_or_library(rtl) port map(
        selector => mux_selector,
        signal1   => signal_1,
        signal2   => signal_2,
        signal3   => signal_3,
        signal4   => signal_4,
        output => output
    );

    -- process
    process is
    begin
        wait for 10 ps;
        mux_selector <= mux_selector + 1;
        wait for 10 ps;
        mux_selector <= mux_selector + 1;
        wait for 10 ps;
        mux_selector <= mux_selector + 1;
        wait for 10 ps;
        mux_selector <= mux_selector + 1;
        wait for 10 ps;
        mux_selector <= "UU";
        wait;
    end process;
end tutorial_15 ; -- tutorial_15