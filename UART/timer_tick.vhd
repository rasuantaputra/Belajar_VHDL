LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY timer_tick IS
	
	GENERIC (
	clk_cnt : INTEGER := 500000000);

	 PORT(clk_50 : IN STD_LOGIC;
			 flag: OUT STD_LOGIC);

END timer_tick;

ARCHITECTURE behavioral OF timer_tick IS
	
BEGIN
	
	PROCESS (clk_50)
		VARIABLE tim_cnt : INTEGER:=0;
	BEGIN
	
		IF rising_edge (clk_50) THEN
			tim_cnt := tim_cnt + 1;
			
			IF tim_cnt < clk_cnt/2-1 THEN
				flag <='1';
			ELSIF tim_cnt < clk_cnt-1 THEN
				flag <= '0';
			ELSE
				tim_cnt := 0;
			END IF;
		
		END IF;
		
	END PROCESS;
	

END behavioral;
