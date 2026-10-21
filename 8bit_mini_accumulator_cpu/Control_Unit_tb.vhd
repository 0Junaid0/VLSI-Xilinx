-- Control_Unit_tb.vhd
-- Testbench for Control Unit (Set 4: LDI, ADD, AND, STA, LDR)

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Control_Unit_tb IS
END Control_Unit_tb;

ARCHITECTURE Behavioral OF Control_Unit_tb IS

    COMPONENT Control_Unit
        PORT(
            OPCODE  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            Z_FLAG  : IN  STD_LOGIC;
            ALU_SEL : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            ACC_EN  : OUT STD_LOGIC;
            R_EN    : OUT STD_LOGIC;
            Z_EN    : OUT STD_LOGIC;
            JUMP    : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL OPCODE  : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL Z_FLAG  : STD_LOGIC := '0';
    SIGNAL ALU_SEL : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL ACC_EN  : STD_LOGIC;
    SIGNAL R_EN    : STD_LOGIC;
    SIGNAL Z_EN    : STD_LOGIC;
    SIGNAL JUMP    : STD_LOGIC;

BEGIN

    UUT : Control_Unit
        PORT MAP(
            OPCODE  => OPCODE,
            Z_FLAG  => Z_FLAG,
            ALU_SEL => ALU_SEL,
            ACC_EN  => ACC_EN,
            R_EN    => R_EN,
            Z_EN    => Z_EN,
            JUMP    => JUMP
        );

    STIM : PROCESS
    BEGIN
        -- Test 1: NOP (opcode 0000)
        -- Expected: all disabled
        OPCODE <= "0000";
        Z_FLAG <= '0';
        WAIT FOR 20 ns;

        -- Test 2: LDI (opcode 0001)
        -- Expected: ALU_SEL=000, ACC_EN=1, R_EN=0, Z_EN=1, JUMP=0
        OPCODE <= "0001";
        WAIT FOR 20 ns;

        -- Test 3: ADD (opcode 0010)
        -- Expected: ALU_SEL=001, ACC_EN=1, R_EN=0, Z_EN=1, JUMP=0
        OPCODE <= "0010";
        WAIT FOR 20 ns;

        -- Test 4: AND (opcode 0100)
        -- Expected: ALU_SEL=010, ACC_EN=1, R_EN=0, Z_EN=1, JUMP=0
        OPCODE <= "0100";
        WAIT FOR 20 ns;

        -- Test 5: STA (opcode 1010)
        -- Expected: ACC_EN=0, R_EN=1, Z_EN=0, JUMP=0
        OPCODE <= "1010";
        WAIT FOR 20 ns;

        -- Test 6: LDR (opcode 1011)
        -- Expected: ALU_SEL=011, ACC_EN=1, R_EN=0, Z_EN=1, JUMP=0
        OPCODE <= "1011";
        WAIT FOR 20 ns;

        -- Test 7: Unknown opcode (0111 = NOT, not in Set 4)
        -- Expected: all disabled (same as NOP)
        OPCODE <= "0111";
        WAIT FOR 20 ns;

        -- Test 8: Another unknown (1100 = JZ, not in Set 4)
        -- Expected: all disabled
        OPCODE <= "1100";
        Z_FLAG <= '1';
        WAIT FOR 20 ns;

        ASSERT FALSE REPORT "Simulation complete." SEVERITY NOTE;
        WAIT;
    END PROCESS;

END Behavioral;
