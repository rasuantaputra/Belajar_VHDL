LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all ; 
use ieee.std_logic_arith.all;

ENTITY tx_serial_tester IS
	
	GENERIC (
	kirim : INTEGER := 235); 
	
	PORT(
	rst : IN STD_LOGIC;
	clk : IN STD_LOGIC;
	
	data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	data_us : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
	data_an : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		
	send_sgl: OUT STD_LOGIC;
	huruf : OUT CHARACTER --STD_LOGIC_VECTOR(7 DOWNTO 0) --CHARACTER;
	);

END tx_serial_tester;

ARCHITECTURE logic OF tx_serial_tester IS
	CONSTANT max_dat : INTEGER := 4;
	TYPE state_type IS (iddle, begin_data, data_send, data_rest, end_data);
	SIGNAL current_s,next_s: state_type;
	TYPE data_char IS ARRAY(0 TO max_dat) OF CHARACTER;
	SIGNAL kata : data_char;
	SIGNAL cnt : INTEGER RANGE 0 TO max_dat;
	
	SIGNAL data_in_con : STD_LOGIC_VECTOR(19 DOWNTO 0);
	
	SIGNAL b_data_us : STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL data_us_con : STD_LOGIC_VECTOR (19 DOWNTO 0);
	
	SIGNAL b_data_an : STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL data_an_con : STD_LOGIC_VECTOR (19 DOWNTO 0);
	
	FUNCTION bitvector_to_character(nilai: STD_LOGIC_VECTOR(3 DOWNTO 0))
		RETURN CHARACTER IS
	BEGIN
		CASE nilai IS
		
			WHEN "0000" =>
				RETURN '0';
			WHEN "0001" =>
				RETURN '1';
			WHEN "0010" =>
				RETURN '2';
			WHEN "0011" =>
				RETURN '3';
			WHEN "0100" =>
				RETURN '4';
			WHEN "0101" =>
				RETURN '5';
			WHEN "0110" =>
				RETURN '6';
			WHEN "0111" =>
				RETURN '7';
			WHEN "1000" =>
				RETURN '8';
			WHEN "1001" =>
				RETURN '9';
			WHEN others =>
				RETURN '0';
		
		END CASE;
	
	
	END bitvector_to_character;
	
	
	--from http://vhdlguru.blogspot.co.id/2010/04/8-bit-binary-to-bcd-converter-double.html
	function to_bcd ( bin : std_logic_vector(15 downto 0) ) return std_logic_vector is
		variable i : integer:=0;
		variable bcd : std_logic_vector(19 downto 0) := (others => '0');
		variable bint : std_logic_vector(15 downto 0) := bin;

	begin
			for i in 0 to 15 loop  -- repeating 8 times.
				bcd(19 downto 1) := bcd(18 downto 0);  --shifting the bits.
				bcd(0) := bint(15);
				bint(15 downto 1) := bint(14 downto 0);
				bint(0) :='0';


				if(i < 15 and bcd(3 downto 0) > "0100") then --add 3 if BCD digit is greater than 4.
					bcd(3 downto 0) := bcd(3 downto 0) + "0011";
				end if;

				if(i < 15 and bcd(7 downto 4) > "0100") then --add 3 if BCD digit is greater than 4.
					bcd(7 downto 4) := bcd(7 downto 4) + "0011";
				end if;

				if(i < 15 and bcd(11 downto 8) > "0100") then  --add 3 if BCD digit is greater than 4.
					bcd(11 downto 8) := bcd(11 downto 8) + "0011";
				end if;
				
				if(i < 15 and bcd(15 downto 12) > "0100") then  --add 3 if BCD digit is greater than 4.
					bcd(15 downto 12) := bcd(15 downto 12) + "0011";
				end if;

				if(i < 15 and bcd(19 downto 16) > "0100") then  --add 3 if BCD digit is greater than 4.
					bcd(19 downto 16) := bcd(19 downto 16) + "0011";
				end if;
				

				end loop;
		return bcd;
	end to_bcd;
	
	
	
BEGIN

	data_in_con <= to_bcd(data_in);
	
	--b_data_us <= "00" & data_us ;
	--data_us_con <= to_bcd(b_data_us);
	
	--b_data_an <= "0000" & data_an ;
	--data_an_con <= to_bcd(b_data_an);
	
	--kata <= ('V','1','2','3','4');
	
	--kata(16) <= bitvector_to_character(data_us_con(3 DOWNTO 0));
	--kata(15) <= bitvector_to_character(data_us_con(7 DOWNTO 4));
	--kata(14) <= bitvector_to_character(data_us_con(11 DOWNTO 8));
	--kata(13) <= bitvector_to_character(data_us_con(15 DOWNTO 12));
	--kata(12) <= bitvector_to_character(data_us_con(19 DOWNTO 16));
	--kata(11) <= '-';
	
	--kata(10) <= bitvector_to_character(data_an_con(3 DOWNTO 0));
	--kata(9) <= bitvector_to_character(data_an_con(7 DOWNTO 4));
	--kata(8) <= bitvector_to_character(data_an_con(11 DOWNTO 8));
	--kata(7) <= bitvector_to_character(data_an_con(15 DOWNTO 12));
	--kata(6) <= bitvector_to_character(data_an_con(19 DOWNTO 16));
	--kata(5) <= '-';
	
	kata(4) <= bitvector_to_character(data_in_con(3 DOWNTO 0));
	kata(3) <= bitvector_to_character(data_in_con(7 DOWNTO 4));
	kata(2) <= bitvector_to_character(data_in_con(11 DOWNTO 8));
	kata(1) <= bitvector_to_character(data_in_con(15 DOWNTO 12));
	kata(0) <= bitvector_to_character(data_in_con(19 DOWNTO 16));
	
	state_change : PROCESS(clk, rst)
	
	BEGIN
	
		IF rst = '1' THEN
				current_s <= iddle;
		ELSIF rising_edge(clk) THEN
				current_s <= next_s;
		END IF;
	
	END PROCESS state_change;
	
	count_data:PROCESS(current_s, clk)
		VARIABLE konter : INTEGER RANGE 0 TO max_dat;
	BEGIN
		
		
		IF rising_edge(clk) THEN
			
			IF current_s = data_send THEN
				konter := konter + 1;
			ELSE
				konter := 0;
			END IF;
			
			--IF konter > 2 THEN
				--konter := 0;
			--END IF;
			cnt<= konter;
		END IF;
	
	END PROCESS count_data;
	
	
	stm : PROCESS(current_s, cnt)
		
	BEGIN
		CASE current_s IS
			WHEN iddle =>
				huruf<=character'val(10);
				--send_sgl <= '0';
				--cnt <= 0;
				next_s <= begin_data;
			WHEN begin_data =>
				huruf <= 'B';--"01000001";
				--cnt<=0;
				--send_sgl <= '1';
				next_s <= data_send;--data_rest;
			WHEN data_send =>
				--huruf <= 'B'; --"01000010";
					
				huruf <= kata(cnt);
				--send_sgl <= '1';
				--next_s <= data_rest;
				IF cnt = max_dat THEN
					next_s <= end_data;
				ELSE
					next_s <= data_send;
				END IF;
				
			WHEN data_rest =>
				
				send_sgl <= '0';
							
			WHEN end_data =>
				huruf <= 'E'; --"01000011";
				--send_sgl <= '1';
				next_s <= iddle;
			WHEN others =>
				current_s <= iddle;
		END CASE;
	END PROCESS stm;


	

END logic;