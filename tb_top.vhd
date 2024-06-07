LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY tb_top IS
END tb_top;

ARCHITECTURE behavior OF tb_top IS

    CONSTANT n : integer := 8;
    CONSTANT k : integer := 3;
    CONSTANT m : integer := 4;

    
    SIGNAL Y_i : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    SIGNAL X_i : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    SIGNAL ALUFN_i : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL ALUout_o : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    SIGNAL Nflag_o, Cflag_o, Zflag_o, Vflag_o : STD_LOGIC;

BEGIN


    UUT : ENTITY WORK.top
        GENERIC MAP(n => n, k => k, m => m)
        PORT MAP(
            Y_i => Y_i,
            X_i => X_i,
            ALUFN_i => ALUFN_i,
            ALUout_o => ALUout_o,
            Nflag_o => Nflag_o,
            Cflag_o => Cflag_o,
            Zflag_o => Zflag_o,
            Vflag_o => Vflag_o
        );

    tb_process : PROCESS
    BEGIN
    
        ALUFN_i <= "01000"; -- ADD
        X_i <= "00001101"; -- 13
        Y_i <= "00000111"; -- 7
        WAIT FOR 100 ns;
        
        ALUFN_i <= "01001"; -- SUB
        X_i <= "00001101"; -- 13
        Y_i <= "00000111"; -- 7
        WAIT FOR 100 ns;
        
     
        ALUFN_i <= "10000"; -- SHIFT LEFT
        X_i <= "00000010"; -- 2 (shift by 2)
        Y_i <= "00001101"; -- 13
        WAIT FOR 100 ns;
        
        ALUFN_i <= "10001"; -- SHIFT RIGHT
        X_i <= "00000010"; -- 2 (shift by 2)
        Y_i <= "00001101"; -- 13
        WAIT FOR 100 ns;

      
        ALUFN_i <= "11000"; -- NOT Y
        X_i <= "00000000";
        Y_i <= "00001101"; -- 13
        WAIT FOR 100 ns;
        
        ALUFN_i <= "11001"; -- OR
        X_i <= "00000110"; -- 6
        Y_i <= "00001101"; -- 13
        WAIT FOR 100 ns;

        ALUFN_i <= "11010"; -- AND
        X_i <= "00000110"; -- 6
        Y_i <= "00001101"; -- 13
        WAIT FOR 100 ns;

        ALUFN_i <= "11011"; -- XOR
        X_i <= "00000110"; -- 6
        Y_i <= "00001101"; -- 13
        WAIT FOR 100 ns;

  
        WAIT;
    END PROCESS;

END behavior;
