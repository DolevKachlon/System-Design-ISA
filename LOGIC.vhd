LIBRARY ieee;
use ieee.std_logic_1164.all;
--------------------------------
ENTITY LOGIC IS 
	GENERIC (n: INTEGER := 8);
	PORT( 
			ALUFN: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			X,Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			OUTPUT : OUT STD_LOGIC_VECTOR (n-1 downto 0)
	);
END LOGIC;
------------------------------------------------------------
architecture LOGIC_ARCH OF LOGIC IS

BEGIN 

	
	OUTPUT <= 	NOT Y WHEN ALUFN = "000" ELSE
				X OR Y WHEN ALUFN = "001" ELSE
				X AND Y WHEN ALUFN = "010" ELSE
				X XOR Y WHEN ALUFN = "011" ELSE
				X NOR Y WHEN ALUFN = "100" ELSE
				X NAND Y WHEN ALUFN = "101" ELSE
				X XNOR Y WHEN ALUFN = "111" ELSE
				(OTHERS => '0');
	
			

END LOGIC_ARCH;
