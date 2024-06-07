LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;
------------------------------------------------------

ENTITY Shifter IS 
    GENERIC (n : INTEGER := 8;   
             k : INTEGER := 3);   -- k=log2(n)
    PORT ( 
        DIR_ALUFN: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        X : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
        Y : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
        COUT : OUT STD_LOGIC; ---carry 
        RES : OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0) --output
    );
END Shifter;	  
		  
--------------------------------------------------------------
ARCHITECTURE Shifter OF Shifter IS

    SIGNAL reg : std_logic_vector(k-1 DOWNTO 0);  
    SUBTYPE vector IS STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    TYPE matrix IS ARRAY (k-1 DOWNTO 0) OF vector; 
    SIGNAL rows : matrix; 
	
BEGIN 	
	
    first : ShifterSub GENERIC MAP (n, 1) 
        PORT MAP(  
            Y => Y,
            Xk => X(0),
            DIR => DIR_ALUFN,
            Cin => '0',
            Cout => reg(0),
            Output => rows(0)
        );
	
    rest : FOR i IN 1 TO k-1 GENERATE  
        chain : ShifterSub GENERIC MAP (n, 2**i) 
            PORT MAP( 
                Y => rows(i-1),
                Xk => X(i),
                DIR => DIR_ALUFN,
                Cin => reg(i-1),
                Cout => reg(i),
                Output => rows(i)
            );
    END GENERATE;
	
    RES <= rows(k-1); --  shifter output
    COUT <= reg(k-1);	-- carry out
	
END Shifter;
