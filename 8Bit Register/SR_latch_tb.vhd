LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SR_latch_tb IS
END SR_latch_tb;

ARCHITECTURE behavior OF SR_latch_tb IS

    COMPONENT SR_latch
    PORT(
        S_n : IN STD_LOGIC;
        R_n : IN STD_LOGIC;
        Q   : OUT STD_LOGIC;
        Qn  : OUT STD_LOGIC
    );
    END COMPONENT;

    SIGNAL S_n : STD_LOGIC := '1';
    SIGNAL R_n : STD_LOGIC := '1';
    SIGNAL Q   : STD_LOGIC;
    SIGNAL Qn  : STD_LOGIC;

BEGIN

    uut: SR_latch PORT MAP (
        S_n => S_n,
        R_n => R_n,
        Q   => Q,
        Qn  => Qn
    );

    stim_proc: PROCESS
    BEGIN
        -- Set
        S_n <= '0'; R_n <= '1';
        WAIT FOR 100 ns;

        -- Hold
        S_n <= '1'; R_n <= '1';
        WAIT FOR 100 ns;

        -- Reset
        S_n <= '1'; R_n <= '0';
        WAIT FOR 100 ns;

        -- Hold
        S_n <= '1'; R_n <= '1';
        WAIT FOR 100 ns;

        -- Set again
        S_n <= '0'; R_n <= '1';
        WAIT FOR 100 ns;

        -- Invalid condition: avoid in normal operation
        -- S_n <= '0'; R_n <= '0';

        WAIT;
    END PROCESS;

END behavior;