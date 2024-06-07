# System-Design-ISA
ALU VHDL Project
This project implements an Arithmetic Logic Unit (ALU) in VHDL, comprising three main modules: ADD_SUB, LOGIC, and Shifter. The project also includes the testbench files for each module, verifying their functionality.

----------------------Project Structure--------------------
The project consists of the following VHDL files:

ADD_SUB.VHD
FA.VHD
LOGIC.VHD
SHIFTER.VHD
SHIFTERSUB.VHD
AUX_PACKAGE.VHD
TOP.VHD

     ---------------------------------
Additionally, the project includes testbench files to validate each module:

tb_AddSub.vhd
tb_LOGIC.vhd
tb_Shifter.vhd
tb_top.vhd
There are also script files to facilitate waveform and signal list viewing:

     ---------------------------------
WAVE.DO
LIST.DO


----------------------Module Descriptions----------------------
ADD_SUB Module
This module performs addition and subtraction operations. It uses the FA (Full Adder) component to implement these operations.

Inputs:
ALUFN: Operation selector (3 bits)
X, Y: Operands (n bits)
Outputs:
Cout: Carry out
Vflag: Overflow flag
S: Result (n bits)
The ADD_SUB module can perform addition, subtraction, and a bitwise NEG (negation) operation on X depending on the ALUFN value.
     ---------------------------------
FA Module
A simple full adder component used by the ADD_SUB module.

Inputs:
xi, yi: Operand bits
cin: Carry in
Outputs:
s: Sum
cout: Carry out

      ---------------------------------
LOGIC Module
This module performs logical operations.

Inputs:
ALUFN: Operation selector (3 bits)
X, Y: Operands (n bits)
Outputs:
OUTPUT: Result (n bits)
The LOGIC module supports operations such as NOT, OR, AND, XOR, NOR, NAND, and XNOR.

     ---------------------------------
SHIFTER Module
This module performs bitwise shift operations.

Inputs:
DIR_ALUFN: Direction and type of shift (3 bits)
X: Shift amount (log2(n) bits)
Y: Operand (n bits)
Outputs:
COUT: Carry out
RES: Result (n bits)
The SHIFTER module can shift left or right by a variable amount specified by X.

     ---------------------------------
SHIFTERSUB Module
A sub-component used by the SHIFTER module to perform individual shift operations.

Inputs:
Y: Operand (n bits)
Xk: Specific bit of X for the shift amount
DIR: Direction of shift (3 bits)
Cin: Carry in
Outputs:
Cout: Carry out
Output: Result (n bits)

     ---------------------------------
AUX_PACKAGE.VHD
This file contains auxiliary definitions and is included where needed in the other modules.

     ---------------------------------
TOP Module
The top-level module integrating the ADD_SUB, LOGIC, and SHIFTER modules.

Inputs:
Y_i, X_i: Operands (n bits)
ALUFN_i: Operation selector (5 bits)
Outputs:
ALUout_o: ALU result (n bits)
Nflag_o, Cflag_o, Zflag_o, Vflag_o: Status flags
The TOP module uses the most significant bits of ALUFN_i to determine which operation to perform.

---------------------------------Testbenches---------------------------------
tb_AddSub.vhd
Testbench for the ADD_SUB module.

Performs a series of addition, subtraction, and bitwise NEG (negation) operations on various inputs.
Verifies the correctness of the Cout and S outputs.

      ---------------------------------
tb_LOGIC.vhd
Testbench for the LOGIC module.

Tests each logical operation (NOT, OR, AND, XOR, NOR, NAND, XNOR) on predefined inputs.
Ensures the OUTPUT signal matches expected values.

     ---------------------------------
tb_Shifter.vhd
Testbench for the Shifter module.

Executes left and right shifts with different shift amounts.
Validates the correctness of RES and COUT outputs.

     ---------------------------------
tb_top.vhd
Testbench for the TOP module.
Integrates tests for all three main modules (ADD_SUB, LOGIC, Shifter).
Executes a sequence of operations (ADD, SUB, SHIFT LEFT, SHIFT RIGHT, NOT, OR, AND, XOR) and checks the resulting outputs and flags.


---------------------------------How to Run---------------------------------
Compile the VHDL files: Ensure all VHDL files are compiled in your simulation tool.
     ---------------------------------
Load the Testbenches: Load the appropriate testbench file for the module you want to test.
     ---------------------------------
Run the Simulations:
Execute the testbenches and observe the waveforms or output logs to verify the functionality of each module.
Use the WAVE.DO and LIST.DO scripts to set up your waveform and signal list views for better visualization of the simulation results.
WAVE.DO: Sets up the waveform view in the simulation tool.
LIST.DO: Sets up the signal list for monitoring in the simulation tool.


---------------------------------Conclusion---------------------------------
This project demonstrates a complete implementation of an ALU in VHDL with extensive testbenches to verify its functionality. The modular design allows easy extension and integration into larger systems.
