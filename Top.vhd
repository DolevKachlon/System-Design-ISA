LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;

ENTITY top IS
  GENERIC (
      n : INTEGER := 8;
      k : integer := 3;   -- k=log2(n)
      m : integer := 4    -- m=2^(k-1)
  );
  PORT (  
      Y_i, X_i: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
      ALUFN_i: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
      Nflag_o, Cflag_o, Zflag_o, Vflag_o: OUT STD_LOGIC
  );
END top;

ARCHITECTURE struct OF top IS 
    SIGNAL RES_ADDSUB: STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    SIGNAL Cout_ADDSUB: STD_LOGIC;
    SIGNAL ADDSUBI: STD_LOGIC;
	SIGNAL V_ADDSUB : STD_LOGIC;
    SIGNAL RES_SHIFTER: STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    SIGNAL Cout_SHIFTER: STD_LOGIC;
    SIGNAL shifterI: STD_LOGIC;
    SIGNAL RES_LOGIC: STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    SIGNAL logicI: STD_LOGIC;
    SIGNAL ALUout_internal: STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    
BEGIN 
    ADDSUBI <= '1' WHEN ALUFN_i(4 DOWNTO 3) = "01" ELSE '0';
    shifterI <= '1' WHEN ALUFN_i(4 DOWNTO 3) = "10" ELSE '0';
    logicI <= '1' WHEN ALUFN_i(4 DOWNTO 3) = "11" ELSE '0';
	
	ADDSUB_COMPONENT: ADD_SUB GENERIC MAP (n) PORT MAP (
					ALUFN => ALUFN_i(2 DOWNTO 0),
					X => X_i,
					Y => Y_i,
					Cout => Cout_ADDSUB,
					Vflag => V_ADDSUB,
					S => RES_ADDSUB
            );
    
    SHIFTER_COMPONENT: SHIFTER GENERIC MAP (n,k) PORT MAP (
                DIR_ALUFN => ALUFN_i(2 DOWNTO 0),
                X => X_i,
                Y => Y_i,
                COUT => Cout_SHIFTER,
                RES => RES_SHIFTER
            );
    
    LOGIC_COMPONENT:LOGIC GENERIC MAP (n)PORT MAP (
                ALUFN => ALUFN_i(2 DOWNTO 0),
                X => X_i,
                Y => Y_i,
                OUTPUT => RES_LOGIC
            );

	
    ALUout_internal <= RES_ADDSUB WHEN ADDSUBI = '1' ELSE
                       RES_SHIFTER WHEN shifterI = '1' ELSE
                       RES_LOGIC WHEN logicI = '1' ELSE
                       (OTHERS => '0');

    ALUout_o <= ALUout_internal;

    Cflag_o <= Cout_ADDSUB WHEN ADDSUBI = '1' ELSE
               Cout_SHIFTER WHEN shifterI = '1' ELSE
               '0';

    Zflag_o <= 	'1' WHEN ALUout_internal = (n-1 downto 0 => '0') ELSE '0';
    Nflag_o <= 	'1' WHEN ALUout_internal(n-1) = '1' ELSE '0';
	Vflag_o <=  '1' WHEN (V_ADDSUB = '1' AND ADDSUBI = '1') ELSE '0';
	
END struct;
