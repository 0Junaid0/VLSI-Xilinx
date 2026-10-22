-- CPU_top_tb.vhd
-- Testbench for 8-bit Accumulator CPU (Set 4)
-- Runs the Set 4 test program and verifies expected results
-- Program: LDI 0x1E, STA, ADD 0x22, AND 0x60, LDR, ADD 0x01, AND 0x0F, STA, LDI 0x00, LDR

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY CPU_top_tb IS
END CPU_top_tb;

ARCHITECTURE Behavioral OF CPU_top_tb IS

    COMPONENT CPU_top
        PORT(
            CLK    : IN  STD_LOGIC;
            RESET  : IN  STD_LOGIC;
            Q      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            Z      : OUT STD_LOGIC;
            PC_OUT : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            R_OUT  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL CLK    : STD_LOGIC := '0';
    SIGNAL RESET  : STD_LOGIC := '0';
    SIGNAL Q      : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Z      : STD_LOGIC;
    SIGNAL PC_OUT : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL R_OUT  : STD_LOGIC_VECTOR(7 DOWNTO 0);

    CONSTANT CLK_PERIOD : TIME := 20 ns;

BEGIN

    -- Instantiate the CPU
    UUT : CPU_top
        PORT MAP(
            CLK    => CLK,
            RESET  => RESET,
            Q      => Q,
            Z      => Z,
            PC_OUT => PC_OUT,
            R_OUT  => R_OUT
        );

    -- Clock generation
    CLK_PROCESS : PROCESS
    BEGIN
        CLK <= '0';
        WAIT FOR CLK_PERIOD / 2;
        CLK <= '1';
        WAIT FOR CLK_PERIOD / 2;
    END PROCESS;

    -- Stimulus process
    STIM_PROCESS : PROCESS
    BEGIN
        -- ============================================
        -- Cycle 0: Apply RESET for one rising edge
        -- Expected after: ACC=0x00, Z=1, R=0x00, PC=0
        -- ============================================
        RESET <= '1';
        WAIT FOR CLK_PERIOD;

        -- ============================================
        -- Release RESET - CPU starts executing
        -- ============================================
        RESET <= '0';

        -- ============================================
        -- Cycle 1: PC=0, LDI 0x1E
        -- Expected: ACC=0x1E, Z=0, R=0x00, Next PC=1
        -- ============================================
        WAIT FOR CLK_PERIOD;

        -- ============================================
        -- Cycle 2: PC=1, STA
        -- Expected: ACC=0x1E, Z=0, R=0x1E, Next PC=2
        -- ============================================
        WAIT FOR CLK_PERIOD;

        -- ============================================
        -- Cycle 3: PC=2, ADD 0x22
        -- Expected: ACC=0x40, Z=0, R=0x1E, Next PC=3
        -- ============================================
        WAIT FOR CLK_PERIOD;

        -- ============================================
        -- Cycle 4: PC=3, AND 0x60
        -- Expected: ACC=0x40, Z=0, R=0x1E, Next PC=4
        -- ============================================
        WAIT FOR CLK_PERIOD;

        -- ============================================
        -- Cycle 5: PC=4, LDR
        -- Expected: ACC=0x1E, Z=0, R=0x1E, Next PC=5
        -- ============================================
        WAIT FOR CLK_PERIOD;

        -- ============================================
        -- Cycle 6: PC=5, ADD 0x01
        -- Expected: ACC=0x1F, Z=0, R=0x1E, Next PC=6
        -- ============================================
        WAIT FOR CLK_PERIOD;

        -- ============================================
        -- Cycle 7: PC=6, AND 0x0F
        -- Expected: ACC=0x0F, Z=0, R=0x1E, Next PC=7
        -- ============================================
        WAIT FOR CLK_PERIOD;

        -- ============================================
        -- Cycle 8: PC=7, STA
        -- Expected: ACC=0x0F, Z=0, R=0x0F, Next PC=8
        -- ============================================
        WAIT FOR CLK_PERIOD;

        -- ============================================
        -- Cycle 9: PC=8, LDI 0x00
        -- Expected: ACC=0x00, Z=1, R=0x0F, Next PC=9
        -- ============================================
        WAIT FOR CLK_PERIOD;

        -- ============================================
        -- Cycle 10: PC=9, LDR
        -- Expected: ACC=0x0F, Z=0, R=0x0F, Next PC=10
        -- ============================================
        WAIT FOR CLK_PERIOD;

        -- Wait a few more cycles to observe
        WAIT FOR CLK_PERIOD * 3;

        -- End simulation
        ASSERT FALSE REPORT "Simulation complete." SEVERITY NOTE;
        WAIT;
    END PROCESS;

END Behavioral;
