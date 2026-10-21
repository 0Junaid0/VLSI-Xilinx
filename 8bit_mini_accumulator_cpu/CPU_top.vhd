LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY CPU_top IS
    PORT(
        CLK    : IN  STD_LOGIC;
        RESET  : IN  STD_LOGIC;
        Q      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);    -- ACC output
        Z      : OUT STD_LOGIC;                        -- Zero flag
        PC_OUT : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);     -- Program Counter
        R_OUT  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)      -- R register (for checking)
    );
END CPU_top;

ARCHITECTURE Structural OF CPU_top IS

    -- ==================== Component Declarations ====================

    COMPONENT PC_4bit
        PORT(
            CLK       : IN  STD_LOGIC;
            RESET     : IN  STD_LOGIC;
            JUMP      : IN  STD_LOGIC;
            JUMP_ADDR : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            PC_OUT    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Program_ROM
        PORT(
            ADDR : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            DATA : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
        );
    END COMPONENT;

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

    COMPONENT Reg_8bit
        PORT(
            D     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            CLK   : IN  STD_LOGIC;
            RESET : IN  STD_LOGIC;
            EN    : IN  STD_LOGIC;
            Q     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            Qn    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Reg_1bit
        PORT(
            D     : IN  STD_LOGIC;
            CLK   : IN  STD_LOGIC;
            RESET : IN  STD_LOGIC;
            EN    : IN  STD_LOGIC;
            Q     : OUT STD_LOGIC;
            Qn    : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT NOT_gate
        PORT(
            A : IN  STD_LOGIC;
            Y : OUT STD_LOGIC
        );
    END COMPONENT;

    -- ==================== Internal Signals ====================

    -- PC signals
    SIGNAL pc_val      : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- ROM signals
    SIGNAL instruction : STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL opcode      : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL operand     : STD_LOGIC_VECTOR(7 DOWNTO 0);

    -- Control signals
    SIGNAL alu_sel_sig : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL acc_en_sig  : STD_LOGIC;
    SIGNAL r_en_sig    : STD_LOGIC;
    SIGNAL z_en_sig    : STD_LOGIC;

    -- ACC signals
    SIGNAL acc_val     : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL acc_qn      : STD_LOGIC_VECTOR(7 DOWNTO 0);

    -- R register signals
    SIGNAL r_val       : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL r_qn        : STD_LOGIC_VECTOR(7 DOWNTO 0);

    -- ALU signals
    SIGNAL alu_result  : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL alu_z       : STD_LOGIC;

    -- Z flag signals
    -- We store NOT(alu_z) in the register. On RESET the register clears to 0,
    -- so Qn=1, meaning Z=1 (correct because ACC=0x00 after reset).
    -- During operation: alu_z=1 -> store NOT(1)=0 -> Qn=1 -> Z=1. Correct.
    --                   alu_z=0 -> store NOT(0)=1 -> Qn=0 -> Z=0. Correct.
    SIGNAL alu_z_inv   : STD_LOGIC;
    SIGNAL z_val       : STD_LOGIC;
    SIGNAL z_q_dummy   : STD_LOGIC;

BEGIN

    -- ==================== Instruction Decoding ====================
    opcode  <= instruction(11 DOWNTO 8);
    operand <= instruction(7 DOWNTO 0);

    -- ==================== Program Counter ====================
    -- Set 4 does NOT have JZ, so JUMP is always '0'
    U_PC : PC_4bit
        PORT MAP(
            CLK       => CLK,
            RESET     => RESET,
            JUMP      => '0',
            JUMP_ADDR => "0000",
            PC_OUT    => pc_val
        );

    -- ==================== Program ROM ====================
    U_ROM : Program_ROM
        PORT MAP(
            ADDR => pc_val,
            DATA => instruction
        );

    -- ==================== Control Unit ====================
    U_CU : Control_Unit
        PORT MAP(
            OPCODE  => opcode,
            Z_FLAG  => z_val,
            ALU_SEL => alu_sel_sig,
            ACC_EN  => acc_en_sig,
            R_EN    => r_en_sig,
            Z_EN    => z_en_sig,
            JUMP    => OPEN
        );

    -- ==================== ALU ====================
    U_ALU : ALU_8bit
        PORT MAP(
            ACC     => acc_val,
            OPERAND => operand,
            R_VAL   => r_val,
            ALU_SEL => alu_sel_sig,
            RESULT  => alu_result,
            Z_OUT   => alu_z
        );

    -- ==================== Accumulator (ACC) Register ====================
    U_ACC : Reg_8bit
        PORT MAP(
            D     => alu_result,
            CLK   => CLK,
            RESET => RESET,
            EN    => acc_en_sig,
            Q     => acc_val,
            Qn    => acc_qn
        );

    -- ==================== R Register (Holding Register) ====================
    -- STA: R <= ACC
    U_R : Reg_8bit
        PORT MAP(
            D     => acc_val,
            CLK   => CLK,
            RESET => RESET,
            EN    => r_en_sig,
            Q     => r_val,
            Qn    => r_qn
        );

    -- ==================== Z Flag Register ====================
    -- Invert alu_z before storing: store NOT(alu_z)
    U_Z_INV : NOT_gate
        PORT MAP(
            A => alu_z,
            Y => alu_z_inv
        );

    -- Store the inverted Z value; read Qn as the actual Z flag
    U_Z : Reg_1bit
        PORT MAP(
            D     => alu_z_inv,
            CLK   => CLK,
            RESET => RESET,
            EN    => z_en_sig,
            Q     => z_q_dummy,
            Qn    => z_val
        );

    -- ==================== Output Assignments ====================
    Q      <= acc_val;
    Z      <= z_val;
    PC_OUT <= pc_val;
    R_OUT  <= r_val;

END Structural;
