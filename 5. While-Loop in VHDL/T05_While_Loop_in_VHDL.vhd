entity T05_while_loop is
end T05_while_loop;

architecture tutorial_5 of T05_while_loop is
begin

        process is
            variable i : integer := 0;
        begin           
            report "The begining of process";

            while i <= 10 loop
                report "iterasi ke-" & integer'image(i);
                i := i + 1;
            end loop;
                
            report "The end of program ";
            wait;
        end process;
end tutorial_5;