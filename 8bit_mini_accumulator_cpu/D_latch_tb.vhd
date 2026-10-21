
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY D_latch_tb IS
END D_latch_tb;

ARCHITECTURE behavior OF D_latch_tb IS

    COMPONENT D_latch
        PORT(
            D  : IN  STD_LOGIC;
            EN : IN  STD_LOGIC;
            Q  : OUT STD_LOGIC;
            Qn : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL D  : STD_LOGIC := '0';
    SIGNAL EN : STD_LOGIC := '0';
    SIGNAL Q  : STD_LOGIC;
    SIGNAL Qn : STD_LOGIC;

BEGIN

    UUT : D_latch
        PORT MAP(
            D  => D,
            EN => EN,
            Q  => Q,
            Qn => Qn
        );

    stim_proc : PROCESS
    BEGIN
        -- Enable low: latch holds its previous state
        D <= '0'; EN <= '0';
        WAIT FOR 100 ns;

        -- Enable high: latch follows D = 1
        D <= '1'; EN <= '1';
        WAIT FOR 100 ns;

        -- Enable high: latch follows D = 0
        D <= '0'; EN <= '1';
        WAIT FOR 100 ns;

        -- Enable low: latch holds Q = 0
        D <= '1'; EN <= '0';
        WAIT FOR 100 ns;

        -- Enable high: latch follows D = 1
        D <= '1'; EN <= '1';
        WAIT FOR 100 ns;

        WAIT;
    END PROCESS;

END behavior;