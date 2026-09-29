LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY D_latch_tb IS
END D_latch_tb;

ARCHITECTURE behavior OF D_latch_tb IS

    COMPONENT D_latch
    PORT(
        D  : IN STD_LOGIC;
        EN : IN STD_LOGIC;
        Q  : OUT STD_LOGIC;
        Qn : OUT STD_LOGIC
    );
    END COMPONENT;

    SIGNAL D  : STD_LOGIC := '0';
    SIGNAL EN : STD_LOGIC := '0';
    SIGNAL Q  : STD_LOGIC;
    SIGNAL Qn : STD_LOGIC;

BEGIN

    uut: D_latch PORT MAP (
        D  => D,
        EN => EN,
        Q  => Q,
        Qn => Qn
    );

    stim_proc: PROCESS
    BEGIN
        -- Disabled, output holds
        D <= '0'; EN <= '0';
        WAIT FOR 100 ns;

        -- Enabled, store 1
        D <= '1'; EN <= '1';
        WAIT FOR 100 ns;

        -- Disabled, hold 1 despite D changing
        EN <= '0'; D <= '0';
        WAIT FOR 100 ns;

        -- Enabled, store 0
        EN <= '1';
        WAIT FOR 100 ns;

        -- Enabled, store 1
        D <= '1';
        WAIT FOR 100 ns;

        -- Disable and hold
        EN <= '0'; D <= '0';
        WAIT FOR 100 ns;

        WAIT;
    END PROCESS;

END behavior;