entity T03_loop_n_exit is
end entity;

architecture tutorial_3 of T03_loop_n_exit is
begin

    process is
    begin
        report "Awal program";

        loop
            report "Masuk ke dalam Loop";
                
            -- for exit from loop
            exit;
        end loop;

        report "Akhir program";
        wait;
            
    end process;


end architecture;
