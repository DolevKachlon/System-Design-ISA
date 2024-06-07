LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------------------

Entity ShifterSub is 
     GENERIC (n : INTEGER := 8;
		      Shift : INTEGER := 1); 
			  
     port ( Y : IN STD_LOGIC_VECTOR(n-1 downto 0);
	        Xk : IN STD_LOGIC; 
			DIR : STD_LOGIC_VECTOR(2 downto 0); 
			Cin  : IN STD_LOGIC; -- the carry from the previous sub level
			Cout: OUT STD_LOGIC; -- the carry from the current level
			Output : OUT STD_LOGIC_VECTOR(n-1 downto 0)); 
			
End ShifterSub;


architecture Sub of ShifterSub is
	signal Y_VEC : STD_LOGIC_VECTOR(Shift-1 downto 0); -- the limit of shifts is depend on num of bits of Xk = log2(n)
BEGIN 	
    Y_VEC <= (others => '0'); 
	
	
	Output <= Y when Xk = '0' else
	          Y_VEC & Y(n-1 downto Shift) when DIR = "001" else -- shift right
			  Y(n-1-Shift downto 0) & Y_VEC when DIR = "000" else -- shift left
			  (others => '0');
			  
			  
	Cout   <= Cin when Xk = '0' else
	          Y(Shift-1) when DIR = "001" else
			  Y(n-Shift) when DIR = "000" else
			  '0';		  
	
END sub;


