library IEEE;
use ieee.std_logic_1164.all;

package aux_package is
--------------------------------------------------------
	component top is
	GENERIC (n : INTEGER := 8;
		   k : integer := 3;   -- k=log2(n)
		   m : integer := 4	); -- m=2^(k-1)
	PORT 
	(  
		Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC 
	); -- Zflag,Cflag,Nflag,Vflag
	end component;
	
	
---------------------------------------------------------  
	component FA is
		PORT (xi, yi, cin: IN std_logic;
			      s, cout: OUT std_logic
		);
	end component;
---------------------------------------------------------	
	 
	component ADD_SUB IS 
		GENERIC (n: INTEGER := 8);
		PORT( 
			ALUFN: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			X,Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			Cout: OUT STD_LOGIC;
			Vflag : OUT STD_LOGIC;
			S: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0)
		);
	END component;
	
----------------------------------------------------------

	component LOGIC IS 
		GENERIC (n: INTEGER := 8);
		PORT( 
			ALUFN: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			X,Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			OUTPUT : OUT STD_LOGIC_VECTOR (n-1 downto 0)
		);
	END component;	
	
----------------------------------------------------------
	
	component Shifter is 
     GENERIC (n : INTEGER := 8;   
		      k : integer := 3);   -- k=log2(n)
	PORT ( 
			DIR_ALUFN: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			X : IN STD_LOGIC_VECTOR (k-1 downto 0);
			Y : IN STD_LOGIC_VECTOR (n-1 downto 0);
			COUT : OUT STD_LOGIC; ---carry 
			RES : OUT STD_LOGIC_VECTOR (n-1 downto 0) --output
	);
	END component;
	
	
	

	component ShifterSub is 
		GENERIC (n : INTEGER := 8;
				Shift : INTEGER := 1); 
		port ( Y : IN STD_LOGIC_VECTOR(n-1 downto 0);
				Xk : IN STD_LOGIC; 
				DIR : STD_LOGIC_VECTOR(2 downto 0); 
				Cin  : IN STD_LOGIC; -- the carry from the previous sub level
				Cout: OUT STD_LOGIC; -- the carry from the current level
				Output : OUT STD_LOGIC_VECTOR(n-1 downto 0)); 
	End component;


end aux_package;


