-- Control_Unit.vhd
-- Decodes opcode[3:0] and generates control signals for Set 4
-- Fully structural implementation using Decoder_4to16, OR_gate, and AND_gate
--
-- Opcodes:
--   LDI : 0001 -> dec_out(1)
--   ADD : 0010 -> dec_out(2)
--   AND : 0100 -> dec_out(4)
--   STA : 1010 -> dec_out(10)
--   LDR : 1011 -> dec_out(11)
--
-- Control Outputs:
--   ACC_EN  = LDI or ADD or AND or LDR = dec(1) or dec(2) or dec(4) or dec(11)
--   R_EN    = STA                      = dec(10)
--   Z_EN    = LDI or ADD or AND or LDR = dec(1) or dec(2) or dec(4) or dec(11)
--   ALU_SEL = "000" for LDI (00)
--             "001" for ADD (01)
--             "010" for AND (10)
--             "011" for LDR (11)
--             Bit 0 = ADD or LDR = dec(2) or dec(11)
--             Bit 1 = AND or LDR = dec(4) or dec(11)
--             Bit 2 = '0'

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

ARCHITECTURE Structural OF Control_Unit IS

    COMPONENT Decoder_4to16
        PORT(
            A : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            Y : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT OR_gate
        PORT(
            A : IN  STD_LOGIC;
            B : IN  STD_LOGIC;
            Y : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL dec_out : STD_LOGIC_VECTOR(15 DOWNTO 0);

    -- Intermediate OR signals for ACC_EN / Z_EN
    SIGNAL or_1_2    : STD_LOGIC;
    SIGNAL or_4_11   : STD_LOGIC;
    SIGNAL acc_z_sig : STD_LOGIC;

    -- ALU_SEL bit signals
    SIGNAL sel_bit0 : STD_LOGIC;
    SIGNAL sel_bit1 : STD_LOGIC;

BEGIN

    -- 1. Decode opcode[3:0] into 16 one-hot signals
    U_DEC : Decoder_4to16
        PORT MAP(
            A => OPCODE,
            Y => dec_out
        );

    -- 2. ACC_EN & Z_EN = dec(1) OR dec(2) OR dec(4) OR dec(11)
    OR_A : OR_gate PORT MAP(A => dec_out(1),  B => dec_out(2),  Y => or_1_2);
    OR_B : OR_gate PORT MAP(A => dec_out(4),  B => dec_out(11), Y => or_4_11);
    OR_C : OR_gate PORT MAP(A => or_1_2,      B => or_4_11,     Y => acc_z_sig);

    ACC_EN <= acc_z_sig;
    Z_EN   <= acc_z_sig;

    -- 3. R_EN = dec(10) (STA)
    R_EN <= dec_out(10);

    -- 4. ALU_SEL(0) = dec(2) OR dec(11) (ADD or LDR)
    OR_SEL0 : OR_gate PORT MAP(A => dec_out(2), B => dec_out(11), Y => sel_bit0);

    -- 5. ALU_SEL(1) = dec(4) OR dec(11) (AND or LDR)
    OR_SEL1 : OR_gate PORT MAP(A => dec_out(4), B => dec_out(11), Y => sel_bit1);

    ALU_SEL(0) <= sel_bit0;
    ALU_SEL(1) <= sel_bit1;
    ALU_SEL(2) <= '0';

    -- 6. JUMP = '0' for Set 4
    JUMP <= '0';

END Structural;
