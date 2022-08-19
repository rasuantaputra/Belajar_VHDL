entity T09_sensitivity_list is
end T09_sensitivity_list;

architecture tutorial_9 of T09_sensitivity_list is
    signal count_up : integer := 0;
    signal count_down : integer := 10;
begin

    process is
    begin
        count_up <= count_up + 1;
        count_down <= count_down - 1;

        wait for 10 ps;
    end process;

    -- this process trigered with wait on
    process is
    begin
        if count_up = count_down then
            report "Proses ini di triger dengan 'wait on'";
        end if;

        wait on count_up, count_down;
    end process;

    -- this process using sensitive list
    process(count_up, count_down) is
    begin
        if count_up = count_down then
            report "Poses ini menggunakan sesitive list";
        end if ;
    end process;
end tutorial_9;