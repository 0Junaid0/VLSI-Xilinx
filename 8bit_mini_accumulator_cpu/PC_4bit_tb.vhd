-- PC_4bit_tb.vhd
-- Testbench for 4-bit Program Counter

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY PC_4bit_tb IS
END PC_4bit_tb;

ARCHITECTURE Behavioral OF PC_4bit_tb IS

    COMPONENT PC_4bit
        PORT(
            CLK       : IN  STD_LOGIC;
            RESET     : IN  STD_LOGIC;
            JUMP      : IN  STD_LOGIC;
            JUMP_ADDR : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            PC_OUT    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL CLK       : STD_LOGIC := '0';
    SIGNAL RESET     : STD_LOGIC := '0';
    SIGNAL JUMP      : STD_LOGIC := '0';
    SIGNAL JUMP_ADDR : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL PC_OUT    : STD_LOGIC_VECTOR(3 DOWNTO 0);

    CONSTANT CLK_PERIOD : TIME := 20 ns;

BEGIN

    UUT : PC_4bit
        PORT MAP(
            CLK       => CLK,
            RESET     => RESET,
            JUMP      => JUMP,
            JUMP_ADDR => JUMP_ADDR,
            PC_OUT    => PC_OUT
        );

    -- Clock generation
    CLK_PROCESS : PROCESS
    BEGIN
        CLK <= '0';
        WAIT FOR CLK_PERIOD / 2;
        CLK <= '1';
        WAIT FOR CLK_PERIOD / 2;
    END PROCESS;

    STIM : PROCESS
    BEGIN
        -- Test 1: Apply RESET -> PC should be 0
        RESET <= '1';
        JUMP  <= '0';
        WAIT FOR CLK_PERIOD;

        -- Test 2: Release RESET, PC should increment: 0->1
        RESET <= '0';
        WAIT FOR CLK_PERIOD;
        -- PC should now be 1

        -- Test 3: PC increments: 1->2
        WAIT FOR CLK_PERIOD;
        -- PC should now be 2

        -- Test 4: PC increments: 2->3
        WAIT FOR CLK_PERIOD;
        -- PC should now be 3

        -- Test 5: PC increments: 3->4
        WAIT FOR CLK_PERIOD;
        -- PC should now be 4

        -- Test 6: Jump to address 0xA (1010)
        JUMP      <= '1';
        JUMP_ADDR <= "1010";
        WAIT FOR CLK_PERIOD;
        -- PC should now be 10 (0xA)

        -- Test 7: Release JUMP, should increment from 10->11
        JUMP <= '0';
        WAIT FOR CLK_PERIOD;
        -- PC should now be 11

        -- Test 8: Continue incrementing: 11->12
        WAIT FOR CLK_PERIOD;
        -- PC should now be 12

        -- Test 9: Reset again
        RESET <= '1';
        WAIT FOR CLK_PERIOD;
        -- PC should be 0

        RESET <= '0';
        WAIT FOR CLK_PERIOD;
        -- PC should be 1

        ASSERT FALSE REPORT "Simulation complete." SEVERITY NOTE;
        WAIT;
    END PROCESS;

END Behavioral;
