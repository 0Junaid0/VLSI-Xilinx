-- Control_Unit.vhd
-- Decodes opcode[3:0] and the Z flag to generate control signals
-- Set 4 instructions: LDI(0001), ADD(0010), AND(0100), STA(1010), LDR(1011)

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Control_Unit IS
    PORT(
        OPCODE    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);   -- instruction opcode
        Z_FLAG    : IN  STD_LOGIC;                       -- current Z flag value
        ALU_SEL   : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);   -- ALU function select
        ACC_EN    : OUT STD_LOGIC;                       -- accumulator load enable
        R_EN      : OUT STD_LOGIC;                       -- R register load enable
        Z_EN      : OUT STD_LOGIC;                       -- Z flag update enable
        JUMP      : OUT STD_LOGIC                        -- PC jump control
    );
END Control_Unit;

ARCHITECTURE Behavioral OF Control_Unit IS
BEGIN

    PROCESS(OPCODE, Z_FLAG)
    BEGIN
        -- Default: all disabled
        ALU_SEL <= "000";
        ACC_EN  <= '0';
        R_EN    <= '0';
        Z_EN    <= '0';
        JUMP    <= '0';

        CASE OPCODE IS
            -- LDI imm: ACC <= imm, Z updated
            WHEN "0001" =>
                ALU_SEL <= "000";   -- pass operand through
                ACC_EN  <= '1';
                Z_EN    <= '1';

            -- ADD imm: ACC <= ACC + imm, Z updated
            WHEN "0010" =>
                ALU_SEL <= "001";   -- add
                ACC_EN  <= '1';
                Z_EN    <= '1';

            -- AND imm: ACC <= ACC AND imm, Z updated
            WHEN "0100" =>
                ALU_SEL <= "010";   -- and
                ACC_EN  <= '1';
                Z_EN    <= '1';

            -- STA: R <= ACC, Z unchanged
            WHEN "1010" =>
                ALU_SEL <= "000";
                ACC_EN  <= '0';
                R_EN    <= '1';
                Z_EN    <= '0';

            -- LDR: ACC <= R, Z updated
            WHEN "1011" =>
                ALU_SEL <= "011";   -- load from R
                ACC_EN  <= '1';
                Z_EN    <= '1';

            -- NOP (0000) or unrecognized: do nothing
            WHEN OTHERS =>
                NULL;
        END CASE;
    END PROCESS;

END Behavioral;
