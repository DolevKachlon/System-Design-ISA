LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;

ENTITY ADD_SUB IS 
    GENERIC (n: INTEGER := 8);
    PORT( 
        ALUFN: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        X, Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
        Cout: OUT STD_LOGIC;
		Vflag : OUT STD_LOGIC;
        S: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0)
    );
END ADD_SUB;

ARCHITECTURE Adder_Subtractor OF ADD_SUB IS 

    COMPONENT FA IS
        PORT (
            Xi, Yi, Cin: IN std_logic;
            S, Cout: OUT std_logic
        );
    END COMPONENT;
    
    SIGNAL reg: std_logic_vector (n-1 DOWNTO 0);
    SIGNAL sub_cont: std_logic;
    SIGNAL Y_NEW: std_logic_vector(n-1 DOWNTO 0);
    SIGNAL XxorSub: std_logic_vector(n-1 DOWNTO 0); 
    SIGNAL Si: std_logic_vector(n-1 DOWNTO 0);
	SIGNAL OVERFLOW :  std_logic;


BEGIN

    sub_cont <= '0' WHEN ALUFN = "000" ELSE
                '1' WHEN ALUFN = "001" ELSE
                '1' WHEN ALUFN = "010" ELSE
                '0';

    Y_NEW <=   (OTHERS => '0') WHEN ALUFN = "010" ELSE    
                Y;
	
	with sub_cont select				
	XxorSub <= x when '0',					
	        not x when others;


    FIRST : FA PORT MAP (
            Xi => XxorSub(0),
            Yi => Y_NEW(0),
            Cin => sub_cont,
            S    => Si(0),
            Cout => reg(0)
        );
                
    REST : FOR i IN 1 TO n-1 GENERATE 
        chain: FA PORT MAP(
                Xi => XxorSub(i),
                Yi => Y_NEW(i),
                Cin => reg(i-1),
                S => Si(i),
                Cout => reg(i)
            );
    END GENERATE;
                    
    Cout <= reg(n-1);
	S <= Si;
	
	 OVERFLOW <= 	((X(n-1) AND Y(n-1) AND NOT Si(n-1)) OR (NOT X(n-1) AND NOT Y(n-1) AND Si(n-1))) WHEN ALUFN = "000" ELSE
					((not Y(n-1) AND X(n-1) AND Si(n-1)) OR (Y(n-1) AND NOT X(n-1) AND not Si(n-1))) WHEN ALUFN = "001" ELSE 
					'0'; 
				
	Vflag <= OVERFLOW;
	
    
END Adder_Subtractor;
