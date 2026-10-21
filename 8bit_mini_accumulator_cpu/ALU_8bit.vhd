-- ALU_8bit.vhd
-- 8-bit ALU for Set 4: LDI, ADD, AND, plus pass-through for LDR
-- Combinational unit: takes ACC value, operand, R value, and ALU_SEL
-- Outputs the result and zero flag (via Zero_Detector)

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

    COMPONENT Zero_Detector
        PORT(
            D : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            Z : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL add_result  : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL and_result  : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL alu_out     : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL add_cout    : STD_LOGIC;

BEGIN

    -- ADD: ACC + OPERAND
    U_ADD : Full_Adder_8bit
        PORT MAP(
            A    => ACC,
            B    => OPERAND,
            Cin  => '0',
            Sum  => add_result,
            Cout => add_cout
        );

    -- AND: ACC AND OPERAND (bit by bit using AND_gate)
    AND0 : AND_gate PORT MAP(A => ACC(0), B => OPERAND(0), Y => and_result(0));
    AND1 : AND_gate PORT MAP(A => ACC(1), B => OPERAND(1), Y => and_result(1));
    AND2 : AND_gate PORT MAP(A => ACC(2), B => OPERAND(2), Y => and_result(2));
    AND3 : AND_gate PORT MAP(A => ACC(3), B => OPERAND(3), Y => and_result(3));
    AND4 : AND_gate PORT MAP(A => ACC(4), B => OPERAND(4), Y => and_result(4));
    AND5 : AND_gate PORT MAP(A => ACC(5), B => OPERAND(5), Y => and_result(5));
    AND6 : AND_gate PORT MAP(A => ACC(6), B => OPERAND(6), Y => and_result(6));
    AND7 : AND_gate PORT MAP(A => ACC(7), B => OPERAND(7), Y => and_result(7));

    -- MUX for ALU output (combinational process)
    PROCESS(ALU_SEL, OPERAND, add_result, and_result, R_VAL)
    BEGIN
        CASE ALU_SEL IS
            WHEN "000"  => alu_out <= OPERAND;      -- LDI: pass operand
            WHEN "001"  => alu_out <= add_result;    -- ADD: ACC + operand
            WHEN "010"  => alu_out <= and_result;    -- AND: ACC AND operand
            WHEN "011"  => alu_out <= R_VAL;         -- LDR: load from R
            WHEN OTHERS => alu_out <= "00000000";    -- NOP
        END CASE;
    END PROCESS;

    RESULT <= alu_out;

    -- Zero flag detection using separate Zero_Detector entity
    U_ZERO : Zero_Detector
        PORT MAP(
            D => alu_out,
            Z => Z_OUT
        );

END Structural;
