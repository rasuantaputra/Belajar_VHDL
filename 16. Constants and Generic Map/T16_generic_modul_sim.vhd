-- The purpose of this tutorial is to make variables can change from outside
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T16_generic_modul_sim is
end T16_generic_modul_sim;

architecture tutorial_16 of T16_generic_modul_sim is

    -- input bit do u want
    -- bikin variabel tempatnya bebas, bisa seperti signal ataupun di dalam proses 
    constant dataWidth : integer := 8;

    signal signal_1 : unsigned(dataWidth - 1 downto 0) :=   x"AA";
    signal signal_2 : unsigned(dataWidth - 1 downto 0) :=   x"BB";
    signal signal_3 : unsigned(dataWidth - 1 downto 0) :=   x"CC";
    signal signal_4 : unsigned(dataWidth - 1 downto 0) :=   x"DD";

    -- data type should be same with generic map
    signal mux_selector : signed(1 downto 0) := (others => '0');

    signal output : unsigned(dataWidth - 1 downto 0);
begin
    coba_menggunakan_generic_map : entity work.T16_generic_modul(rtl) 
    generic map (data_width => dataWidth)
    port map (
        signal1 => signal_1,
        signal2 => signal_2,
        signal3 => signal_3,
        signal4 => signal_4,

        selector => mux_selector,

        output => output
      );

    proses_generic_map : process is
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
    end process ; -- proses_generic_map
end tutorial_16 ;