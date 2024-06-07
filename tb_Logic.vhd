LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY tb_LOGIC IS
END tb_LOGIC;

ARCHITECTURE rtb OF tb_LOGIC IS

    CONSTANT n : integer := 8;
    CONSTANT ROWmax : integer := 6;  

  
    SIGNAL Y : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    SIGNAL X : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    SIGNAL ALUFN : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL OUTPUT : STD_LOGIC_VECTOR(n-1 DOWNTO 0);

    TYPE mem IS ARRAY (0 TO ROWmax) OF STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Icache : mem := (
        "000", "001", "010", "011", "100", "101", "111"
    );

BEGIN

    UUT : ENTITY WORK.LOGIC GENERIC MAP(n => n) PORT MAP(
            X => X,
            Y => Y,
            ALUFN => ALUFN,
            OUTPUT => OUTPUT
        );

    tb_process : PROCESS
    BEGIN
        
        X <= "01101011";
        Y <= "11001010";

        FOR i IN 0 TO ROWmax LOOP
            ALUFN <= Icache(i);
            WAIT FOR 50 ns;
        END LOOP;
        WAIT;
    END PROCESS;

END rtb;
