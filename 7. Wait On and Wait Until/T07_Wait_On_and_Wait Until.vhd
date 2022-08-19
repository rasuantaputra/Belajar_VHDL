entity T07_waitOn_n_waitUntil is
end T07_waitOn_n_waitUntil;

architecture tutorial_7 of T07_waitOn_n_waitUntil is

    signal count_up : integer := 0;
    signal count_down : integer := 10;
begin
    
    process is
    begin
        count_up <= count_up + 1;
        count_down <= count_down - 1;

        wait for 10 ps;
    end process;

    process is
    begin
        -- will runing if count_up and count_down value cahnge
        wait on count_up, count_down;
        report "Niali Count Up = " & integer'image(count_up) & " | Nilai Count Down = " & integer'image(count_down);        
    end process;

    process is
    begin
        -- will runing until count_up and count_down have a same value
        wait until count_up = count_down;
        report "Jackpot !";
    end process;
end tutorial_7;