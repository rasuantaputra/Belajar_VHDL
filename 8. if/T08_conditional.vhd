entity T08_conditional  is
end T08_conditional ;


architecture tutorial_8 of T08_conditional is
    signal countUp : integer := 0;
    signal countDown : integer := 10;
begin
    process is
    begin

        countUp <= countUp + 1;
        countDown <= countDown - 1;

        wait for 10 ps;
    end process;

    process is
    begin
        if countUp > countDown then
            report "Nilai countUp lebih besar !";
        elsif countUp < countDown then
            report "Nilai countDown lebih besar !";
        else
            report "Nilai keduanya sama :)";
        end if;

        wait on countUp, countDown;
    end process;
end tutorial_8;