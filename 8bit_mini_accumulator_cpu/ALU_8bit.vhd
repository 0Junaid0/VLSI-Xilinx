-- ALU_8bit.vhd
-- 8-bit ALU for Set 4: LDI, ADD, AND, LDR
-- Completely structural architecture:
--   - Uses Full_Adder_8bit for ADD
--   - Uses AND_gate (8 instances) for bitwise AND
--   - Uses MUX_4to1 (8 instances) for result multiplexing:
--       ALU_SEL = "000" / "00" => OPERAND (LDI)
--       ALU_SEL = "001" / "01" => ADD Result
--       ALU_SEL = "010" / "10" => AND Result
--       ALU_SEL = "011" / "11" => R_VAL (LDR)
--   - Uses Zero_Detector (built from NOR_gate and AND_gate) for zero flag

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ALU_8bit IS
    PORT(
        ACC     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);   -- current accumulator value
        OPERAND : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);   -- 8-bit immediate from instruction
        R_VAL   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);   -- current R register value
        ALU_SEL : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);   -- operation select
        RESULT  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);   -- ALU result
        Z_OUT   : OUT STD_LOGIC                        -- 1 if result = 0x00
    );
END ALU_8bit;

ARCHITECTURE Structural OF ALU_8bit IS

    COMPONENT Full_Adder_8bit
        PORT(
            A    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            B    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            Cin  : IN  STD_LOGIC;
            Sum  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            Cout : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT AND_gate
        PORT(
            A : IN  STD_LOGIC;
            B : IN  STD_LOGIC;
            Y : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT MUX_4to1
        PORT(
            D0 : IN  STD_LOGIC;
            D1 : IN  STD_LOGIC;
            D2 : IN  STD_LOGIC;
            D3 : IN  STD_LOGIC;
            S  : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
            Y  : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT Zero_Detector
        PORT(
            D : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            Z : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL add_result : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL and_result : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL alu_out    : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL add_cout   : STD_LOGIC;

BEGIN

    -- 1. ADD: ACC + OPERAND (8-bit adder instance)
    U_ADD : Full_Adder_8bit
        PORT MAP(
            A    => ACC,
            B    => OPERAND,
            Cin  => '0',
            Sum  => add_result,
            Cout => add_cout
        );

    -- 2. AND: ACC AND OPERAND (8 AND_gate instances)
    G_AND0 : AND_gate PORT MAP(A => ACC(0), B => OPERAND(0), Y => and_result(0));
    G_AND1 : AND_gate PORT MAP(A => ACC(1), B => OPERAND(1), Y => and_result(1));
    G_AND2 : AND_gate PORT MAP(A => ACC(2), B => OPERAND(2), Y => and_result(2));
    G_AND3 : AND_gate PORT MAP(A => ACC(3), B => OPERAND(3), Y => and_result(3));
    G_AND4 : AND_gate PORT MAP(A => ACC(4), B => OPERAND(4), Y => and_result(4));
    G_AND5 : AND_gate PORT MAP(A => ACC(5), B => OPERAND(5), Y => and_result(5));
    G_AND6 : AND_gate PORT MAP(A => ACC(6), B => OPERAND(6), Y => and_result(6));
    G_AND7 : AND_gate PORT MAP(A => ACC(7), B => OPERAND(7), Y => and_result(7));

    -- 3. Output selection via 8 MUX_4to1 instances (pure structural)
    -- Select using ALU_SEL(1 downto 0):
    --   "00" => D0 (OPERAND for LDI)
    --   "01" => D1 (add_result for ADD)
    --   "10" => D2 (and_result for AND)
    --   "11" => D3 (R_VAL for LDR)
    MUX_BIT0 : MUX_4to1 PORT MAP(D0 => OPERAND(0), D1 => add_result(0), D2 => and_result(0), D3 => R_VAL(0), S => ALU_SEL(1 DOWNTO 0), Y => alu_out(0));
    MUX_BIT1 : MUX_4to1 PORT MAP(D0 => OPERAND(1), D1 => add_result(1), D2 => and_result(1), D3 => R_VAL(1), S => ALU_SEL(1 DOWNTO 0), Y => alu_out(1));
    MUX_BIT2 : MUX_4to1 PORT MAP(D0 => OPERAND(2), D1 => add_result(2), D2 => and_result(2), D3 => R_VAL(2), S => ALU_SEL(1 DOWNTO 0), Y => alu_out(2));
    MUX_BIT3 : MUX_4to1 PORT MAP(D0 => OPERAND(3), D1 => add_result(3), D2 => and_result(3), D3 => R_VAL(3), S => ALU_SEL(1 DOWNTO 0), Y => alu_out(3));
    MUX_BIT4 : MUX_4to1 PORT MAP(D0 => OPERAND(4), D1 => add_result(4), D2 => and_result(4), D3 => R_VAL(4), S => ALU_SEL(1 DOWNTO 0), Y => alu_out(4));
    MUX_BIT5 : MUX_4to1 PORT MAP(D0 => OPERAND(5), D1 => add_result(5), D2 => and_result(5), D3 => R_VAL(5), S => ALU_SEL(1 DOWNTO 0), Y => alu_out(5));
    MUX_BIT6 : MUX_4to1 PORT MAP(D0 => OPERAND(6), D1 => add_result(6), D2 => and_result(6), D3 => R_VAL(6), S => ALU_SEL(1 DOWNTO 0), Y => alu_out(6));
    MUX_BIT7 : MUX_4to1 PORT MAP(D0 => OPERAND(7), D1 => add_result(7), D2 => and_result(7), D3 => R_VAL(7), S => ALU_SEL(1 DOWNTO 0), Y => alu_out(7));

    RESULT <= alu_out;

    -- 4. Zero detection via Zero_Detector instance (structural NOR tree + AND gates)
    U_ZERO : Zero_Detector
        PORT MAP(
            D => alu_out,
            Z => Z_OUT
        );

END Structural;
