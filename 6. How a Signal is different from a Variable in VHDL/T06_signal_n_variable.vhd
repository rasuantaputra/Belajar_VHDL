entity T06_signal_n_variable is
end entity;

architecture tutorial_6 of T06_signal_n_variable is
    -- Signals should be declared here, before 'architecture begin' (at head)
    signal mySignal : integer := 0; 
begin

    process is
        -- variables must be declared here, before 'process begin' (at the top)
        variable myVariable : integer := 0;
    begin
        report "*********************";
    -- =============================================================
    -- The variable will start from 1
    -- The signal will start from 0
        myVariable := myVariable + 1;
        mySignal <= mySignal + 1;

        report "Nilai myVariable = " & integer'image(myVariable) & " || Nilai mySignal = " & integer'image(mySignal);
    --   ===========================================================
    -- The variable will update immediately as formula expect
    -- The signal only updated when the process delay/pauses (wait for 10 ps)
    
        myVariable := myVariable + 1;
        mySignal <= mySignal + 1;

        report "Nilai myVariable = " & integer'image(myVariable) & " || Nilai mySignal = " & integer'image(mySignal);
        

        wait for 10 ps;
    -- ===============================================================
    -- In this section, signal update immediatly cz after delay/pauses
        myVariable := myVariable + 1;
        mySignal <= mySignal + 1;

        report "Nilai myVariable = " & integer'image(myVariable) & " || Nilai mySignal = " & integer'image(mySignal);

        report "*********************";
    end process;
end architecture;