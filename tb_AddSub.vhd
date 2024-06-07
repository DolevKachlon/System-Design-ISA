LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; 

ENTITY tb_AddSub IS
END tb_AddSub;

ARCHITECTURE rtb OF tb_AddSub IS

  
    CONSTANT n : integer := 8;
    CONSTANT ROWmax : integer := 19;

  
    SIGNAL Y : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    SIGNAL X : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    SIGNAL ALUFN : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Cin : STD_LOGIC;
    SIGNAL Cout : STD_LOGIC;
    SIGNAL S : STD_LOGIC_VECTOR(n-1 DOWNTO 0);

  
    TYPE mem IS ARRAY (0 TO ROWmax) OF STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Icache : mem := (
        "000", "000", "001", "001", "010", "010", "000", "000", "001", "001", 
        "000", "000", "001", "001", "010", "010", "000", "000", "001", "001"
    );

BEGIN


    UUT: ENTITY WORK.ADD_SUB
        PORT MAP(
            ALUFN => ALUFN,
            X => X,
            Y => Y,
            Cout => Cout,
            S => S
        );

 
    tb_process : PROCESS
    BEGIN
       
        X <= "00100110";
        Y <= "11101001";
        Cin <= '0';
		ALUFN <= "000" ;
        WAIT FOR 50 ns;

        FOR i IN 0 TO ROWmax LOOP
            ALUFN <= Icache(i);
            WAIT FOR 100 ns;

            CASE Icache(i) IS
                WHEN "000" => 
                    X <= X + "00000001";
                    Y <= Y + "00000001";
                WHEN "001" => 
                    X <= X + "00000010";
                    Y <= Y + "00000001";
                WHEN "010" => 
                    X <= NOT X;
                    Y <= NOT Y;
                WHEN OTHERS =>
            END CASE;
        END LOOP;
        WAIT;
    END PROCESS;

END rtb;
