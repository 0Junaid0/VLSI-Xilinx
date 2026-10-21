
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Reg_1bit_tb IS
END Reg_1bit_tb;

ARCHITECTURE behavior OF Reg_1bit_tb IS

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

    SIGNAL D     : STD_LOGIC := '0';
    SIGNAL CLK   : STD_LOGIC := '0';
    SIGNAL RESET : STD_LOGIC := '0';
    SIGNAL EN    : STD_LOGIC := '0';
    SIGNAL Q     : STD_LOGIC;
    SIGNAL Qn    : STD_LOGIC;

    CONSTANT CLK_PERIOD : TIME := 100 ns;

BEGIN

    UUT : Reg_1bit
        PORT MAP(
            D     => D,
            CLK   => CLK,
            RESET => RESET,
            EN    => EN,
            Q     => Q,
            Qn    => Qn
        );

    -- Generate clock with a 100 ns period
    clk_process : PROCESS
    BEGIN
        WHILE TRUE LOOP
            CLK <= '0';
            WAIT FOR CLK_PERIOD / 2;

            CLK <= '1';
            WAIT FOR CLK_PERIOD / 2;
        END LOOP;
    END PROCESS;

    -- Apply input test cases
    stim_proc : PROCESS
    BEGIN
        -- 1. Reset register on a rising edge
        RESET <= '1';
        EN    <= '0';
        D     <= '1';
        WAIT FOR CLK_PERIOD;

        -- 2. Enable register and store 1
        RESET <= '0';
        EN    <= '1';
        D     <= '1';
        WAIT FOR CLK_PERIOD;

        -- 3. Enable register and store 0
        D <= '0';
        WAIT FOR CLK_PERIOD;

        -- 4. Disable register; Q should hold 0
        EN <= '0';
        D  <= '1';
        WAIT FOR CLK_PERIOD;

        -- 5. Enable register and store 1
        EN <= '1';
        WAIT FOR CLK_PERIOD;

        -- 6. Reset register again
        RESET <= '1';
        WAIT FOR CLK_PERIOD;

        -- 7. Release reset and hold the value
        RESET <= '0';
        EN    <= '0';
        D     <= '1';
        WAIT FOR CLK_PERIOD;

        WAIT;
    END PROCESS;

END behavior;