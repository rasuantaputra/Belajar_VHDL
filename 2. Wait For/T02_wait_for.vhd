entity T02_delay is
end T02_delay;

architecture tutorial_2 of T02_delay is
begin

    process is
        begin
            
            report "coba delay";

            -- delay for 10 pico sec
            wait for 10 ps;
        end process;
end tutorial_2;