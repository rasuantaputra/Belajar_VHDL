entity T01_hallo_world is
end T01_hallo_world;

architecture tutorial_1 of  T01_hallo_world is
begin

    -- start of the process
    process is 
    begin

        -- printing string
        report "Lagi belajar VHDL Broo";
        -- must have, kalau tidak nanti masuk infinite loop
        wait;
    -- the pocess wil loop back to the start from here
    end process;

end tutorial_1;