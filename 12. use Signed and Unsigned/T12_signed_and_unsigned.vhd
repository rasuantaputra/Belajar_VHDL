library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T12_signed_unsigned is
end T12_signed_unsigned;

architecture tutorial_12 of T12_signed_unsigned is
    signal unsCnt : unsigned(7 downto 0) := (others => '0');
    signal sigCnt : signed(7 downto 0) := (others => '0');

    signal uns_4 : unsigned(3 downto 0) := "1000";
    signal sig_4 : signed(3 downto 0) := "1000";

    signal uns_8 : unsigned(7 downto 0) := (others => '0');
    signal sig_8 : signed(7 downto 0) := (others => '0');
begin

    process is
    begin
        wait for 10 ps;

        -- Wraping counter
        unsCnt <= unsCnt + 1;
        sigCnt <= sigCnt + 1;

        -- Adding signal
        -- remember adder consep about (- and +) in binary
        uns_8 <= uns_8 + uns_4;
        sig_8 <= sig_8 + sig_4;
    end process;
end tutorial_12;