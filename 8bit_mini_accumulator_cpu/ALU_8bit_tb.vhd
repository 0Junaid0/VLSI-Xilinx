-- ALU_8bit_tb.vhd
-- Testbench for 8-bit ALU (Set 4: LDI, ADD, AND, LDR)

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ALU_8bit_tb IS
END ALU_8bit_tb;

ARCHITECTURE Behavioral OF ALU_8bit_tb IS

    COMPONENT ALU_8bit
        PORT(
            ACC     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            OPERAND : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            R_VAL   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            ALU_SEL : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
            RESULT  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            Z_OUT   : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL ACC     : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
    SIGNAL OPERAND : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
    SIGNAL R_VAL   : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
    SIGNAL ALU_SEL : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    SIGNAL RESULT  : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Z_OUT   : STD_LOGIC;

BEGIN

    UUT : ALU_8bit
        PORT MAP(
            ACC     => ACC,
            OPERAND => OPERAND,
            R_VAL   => R_VAL,
            ALU_SEL => ALU_SEL,
            RESULT  => RESULT,
            Z_OUT   => Z_OUT
        );

    STIM : PROCESS
    BEGIN
        -- ===== Test 1: LDI (ALU_SEL=000) =====
        -- Load immediate 0x1E -> RESULT=0x1E, Z=0
        ALU_SEL <= "000";
        ACC     <= "00000000";
        OPERAND <= "00011110";   -- 0x1E
        R_VAL   <= "00000000";
        WAIT FOR 20 ns;

        -- ===== Test 2: LDI 0x00 -> Z should be 1 =====
        ALU_SEL <= "000";
        OPERAND <= "00000000";   -- 0x00
        WAIT FOR 20 ns;

        -- ===== Test 3: ADD (ALU_SEL=001) =====
        -- ACC=0x1E + OPERAND=0x22 = 0x40, Z=0
        ALU_SEL <= "001";
        ACC     <= "00011110";   -- 0x1E
        OPERAND <= "00100010";   -- 0x22
        WAIT FOR 20 ns;

        -- ===== Test 4: ADD resulting in zero =====
        -- ACC=0x80 + OPERAND=0x80 = 0x00 (overflow), Z=1
        ALU_SEL <= "001";
        ACC     <= "10000000";   -- 0x80
        OPERAND <= "10000000";   -- 0x80
        WAIT FOR 20 ns;

        -- ===== Test 5: AND (ALU_SEL=010) =====
        -- ACC=0x40 AND OPERAND=0x60 = 0x40, Z=0
        ALU_SEL <= "010";
        ACC     <= "01000000";   -- 0x40
        OPERAND <= "01100000";   -- 0x60
        WAIT FOR 20 ns;

        -- ===== Test 6: AND resulting in zero =====
        -- ACC=0xF0 AND OPERAND=0x0F = 0x00, Z=1
        ALU_SEL <= "010";
        ACC     <= "11110000";   -- 0xF0
        OPERAND <= "00001111";   -- 0x0F
        WAIT FOR 20 ns;

        -- ===== Test 7: LDR (ALU_SEL=011) =====
        -- Load from R: R_VAL=0x1E -> RESULT=0x1E, Z=0
        ALU_SEL <= "011";
        R_VAL   <= "00011110";   -- 0x1E
        WAIT FOR 20 ns;

        -- ===== Test 8: LDR with R=0x00 -> Z=1 =====
        ALU_SEL <= "011";
        R_VAL   <= "00000000";   -- 0x00
        WAIT FOR 20 ns;

        -- ===== Test 9: ADD =====
        -- ACC=0x1F + OPERAND=0x01 = 0x20, Z=0
        ALU_SEL <= "001";
        ACC     <= "00011111";   -- 0x1F
        OPERAND <= "00000001";   -- 0x01
        WAIT FOR 20 ns;

        -- ===== Test 10: AND =====
        -- ACC=0x1F AND OPERAND=0x0F = 0x0F, Z=0
        ALU_SEL <= "010";
        ACC     <= "00011111";   -- 0x1F
        OPERAND <= "00001111";   -- 0x0F
        WAIT FOR 20 ns;

        ASSERT FALSE REPORT "Simulation complete." SEVERITY NOTE;
        WAIT;
    END PROCESS;

END Behavioral;
