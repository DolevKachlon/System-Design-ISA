LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY tb_Shifter IS
END tb_Shifter;

ARCHITECTURE behavior OF tb_Shifter IS

   
    CONSTANT n : integer := 8;
    CONSTANT k : integer := 3;

  
    SIGNAL DIR_ALUFN : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL X : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    SIGNAL Y : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    SIGNAL COUT : STD_LOGIC;
    SIGNAL RES : STD_LOGIC_VECTOR(n-1 DOWNTO 0);

BEGIN

    
    UUT : ENTITY WORK.Shifter
        GENERIC MAP(n => n, k => k) PORT MAP(
            DIR_ALUFN => DIR_ALUFN,
            X => X,
            Y => Y,
            COUT => COUT,
            RES => RES
        );

    
    tb_process : PROCESS
    BEGIN
       
        DIR_ALUFN <= "000"; -- shift L
        X <= "11101011"; -- shift L of 3 bit
        Y <= "10101010";
        WAIT FOR 100 ns;

        
        DIR_ALUFN <= "001"; -- shift R
        X <= "11101011"; --  shift R of 3 bit
        Y <= "10101010";
        WAIT FOR 100 ns;

        
        DIR_ALUFN <= "000"; -- shift L
        X <= "11101010"; -- shift L of 2 bit
        Y <= "11110000";
        WAIT FOR 100 ns;

        
        DIR_ALUFN <= "001"; -- shift R
        X <= "11101010"; -- shift R of 2 bit
        Y <= "11110000";
        WAIT FOR 100 ns;

        
        WAIT;
    END PROCESS;

END behavior;
