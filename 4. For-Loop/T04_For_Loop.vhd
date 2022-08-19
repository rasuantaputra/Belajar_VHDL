entity T04_forLoop is
end T04_forLoop;

architecture tutorial_4 of T04_forLoop is
begin

    process is
    begin

        report "Awal program";

        for i in 1 to 10 loop
            -- gagal 
            -- report "Iterasi ke-" & i;
            -- 
                
            -- for convert integer to string
            report "interasi ke-" & integer'image(i);
        end loop;

        report "Akhir program";
        wait;
    end process;
end tutorial_4;