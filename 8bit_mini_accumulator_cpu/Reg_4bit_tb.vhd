
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Reg_4bit_tb IS
END Reg_4bit_tb;

ARCHITECTURE behavior OF Reg_4bit_tb IS

    COMPONENT Reg_4bit
        PORT(
            D     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            CLK   : IN  STD_LOGIC;
            RESET : IN  STD_LOGIC;
            EN    : IN  STD_LOGIC;
            Q     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            Qn    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL D     : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL CLK   : STD_LOGIC := '0';
    SIGNAL RESET : STD_LOGIC := '0';
    SIGNAL EN    : STD_LOGIC := '0';
    SIGNAL Q     : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Qn    : STD_LOGIC_VECTOR(3 DOWNTO 0);

    CONSTANT CLK_PERIOD : TIME := 100 ns;

BEGIN

    UUT : Reg_4bit
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
        -- 1. Reset the register
        RESET <= '1';
        EN <= '0';
        D <= "1111";
        WAIT FOR CLK_PERIOD;

        -- 2. Load 1010
        RESET <= '0';
        EN <= '1';
        D <= "1010";
        WAIT FOR CLK_PERIOD;

        -- 3. Load 0101
        D <= "0101";
        WAIT FOR CLK_PERIOD;

        -- 4. Disable and check hold
        EN <= '0';
        D <= "1111";
        WAIT FOR CLK_PERIOD;

        -- 5. Enable and load 1100
        EN <= '1';
        D <= "1100";
        WAIT FOR CLK_PERIOD;

        -- 6. Reset again
        RESET <= '1';
        D <= "1111";
        WAIT FOR CLK_PERIOD;

        -- 7. Release reset and check hold
        RESET <= '0';
        EN <= '0';
        D <= "0011";
        WAIT FOR CLK_PERIOD;

        WAIT;
    END PROCESS;

END behavior;