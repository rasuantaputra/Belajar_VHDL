LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all ; 
use ieee.std_logic_arith.all;

ENTITY tx_serial IS
	
	
	PORT(
	rst : IN STD_LOGIC;
	send_sgl : IN STD_LOGIC;
	huruf : IN CHARACTER ; --STD_LOGIC_VECTOR(7 DOWNTO 0); --CHARACTER;
	clk : IN STD_LOGIC;
	busy_sgl : OUT STD_LOGIC;
	tx_out: OUT STD_LOGIC);

END tx_serial;

ARCHITECTURE logic OF tx_serial IS
	TYPE state_type IS (iddle, start_bit, transmit, stop_bit);
	SIGNAL current_s,next_s: state_type;
	SIGNAL konter : INTEGER;
	--SIGNAL kata : STRING(1 TO 5):= "12345";
	--SIGNAL huruf : CHARACTER ;
	SIGNAL data : STD_LOGIC_VECTOR(7 DOWNTO 0); -- := "10000010";
	--SIGNAL data1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	--data1 <= data;
	--huruf <= kata(2);
	--data <= CONV_STD_LOGIC_VECTOR(character'pos(huruf),8);
	data <= CONV_STD_LOGIC_VECTOR(character'pos(huruf),8);
	--data<= "01100001";
	--data<= "01111010";
	
	state_change : PROCESS(clk, rst)
	
	BEGIN
	
		IF rst = '1' THEN
				current_s <= iddle;
		ELSIF rising_edge(clk) THEN
				current_s <= next_s;
		END IF;
	
	END PROCESS state_change;
	
	count_data : PROCESS(current_s, clk)
		VARIABLE cnt : INTEGER;
	BEGIN
		konter <= cnt;
		IF rising_edge(clk) THEN
			
			IF current_s = transmit THEN
				cnt := cnt + 1;
			ELSE
				cnt := 0;
			END IF;
			
			IF cnt > 7 THEN
				cnt := 0;
			END IF;
			
		ELSE
		
		END IF;
	
	END PROCESS count_data;

	stm : PROCESS(current_s, send_sgl, konter)
	
	BEGIN
		CASE current_s IS
			WHEN iddle =>
				tx_out <= '1';
				busy_sgl<= '0';
				IF send_sgl = '1' THEN
					next_s <= start_bit;
				ELSE
					next_s <= iddle;
				END IF;
			WHEN start_bit =>
				tx_out <= '0';
				busy_sgl <= '1';
				next_s <= transmit;
			WHEN transmit =>
				--tx_out <= '1';
				tx_out <= data(konter);
				busy_sgl <='1';
				IF konter = 7 THEN 
					next_s <= stop_bit;
				ELSE
					next_s <= transmit;
				END IF;
			WHEN stop_bit =>
				tx_out <= '1';
				busy_sgl <= '1';
				IF send_sgl = '1' THEN
					next_s <= stop_bit;
				ELSE
					next_s <= iddle;
				END IF;
			WHEN others =>
				current_s <= iddle;
		END CASE;
	END PROCESS stm;

END logic;