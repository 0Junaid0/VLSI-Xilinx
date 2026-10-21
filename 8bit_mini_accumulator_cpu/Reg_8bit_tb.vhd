
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Reg_8bit_tb IS
END Reg_8bit_tb;

ARCHITECTURE behavior OF Reg_8bit_tb IS

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

    SIGNAL D     : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
    SIGNAL CLK   : STD_LOGIC := '0';
    SIGNAL RESET : STD_LOGIC := '0';
    SIGNAL EN    : STD_LOGIC := '0';
    SIGNAL Q     : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Qn    : STD_LOGIC_VECTOR(7 DOWNTO 0);

    CONSTANT CLK_PERIOD : TIME := 100 ns;

BEGIN

    UUT : Reg_8bit
        PORT MAP(
            D => D,
            CLK => CLK,
            RESET => RESET,
            EN => EN,
            Q => Q,
            Qn => Qn
        );

    CLK_PROCESS : PROCESS
    BEGIN
        WHILE TRUE LOOP
            CLK <= '0';
            WAIT FOR CLK_PERIOD / 2;
            CLK <= '1';
            WAIT FOR CLK_PERIOD / 2;
        END LOOP;
    END PROCESS;

    STIM_PROCESS : PROCESS
    BEGIN
        -- 1. Reset
        RESET <= '1';
        EN <= '0';
        D <= "11111111";
        WAIT FOR CLK_PERIOD;

        -- 2. Load 00010101
        RESET <= '0';
        EN <= '1';
        D <= "00010101";
        WAIT FOR CLK_PERIOD;

        -- 3. Load 10101010
        D <= "10101010";
        WAIT FOR CLK_PERIOD;

        -- 4. Hold the previous value
        EN <= '0';
        D <= "11110000";
        WAIT FOR CLK_PERIOD;

        -- 5. Load 11001100
        EN <= '1';
        D <= "11001100";
        WAIT FOR CLK_PERIOD;

        -- 6. Load 11111111
        D <= "11111111";
        WAIT FOR CLK_PERIOD;

        -- 7. Reset again
        RESET <= '1';
        WAIT FOR CLK_PERIOD;

        -- 8. Release reset and hold zero
        RESET <= '0';
        EN <= '0';
        D <= "01010101";
        WAIT FOR CLK_PERIOD;

        WAIT;
    END PROCESS;

END behavior;