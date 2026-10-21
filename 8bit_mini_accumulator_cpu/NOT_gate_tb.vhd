LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY NOT_gate_tb IS
END NOT_gate_tb;

ARCHITECTURE behavior OF NOT_gate_tb IS

    COMPONENT NOT_gate
    PORT(
        A : IN STD_LOGIC;
        Y : OUT STD_LOGIC
    );
    END COMPONENT;

    SIGNAL A : STD_LOGIC := '0';
    SIGNAL Y : STD_LOGIC;

BEGIN

    uut: NOT_gate PORT MAP (
        A => A,
        Y => Y
    );

    stim_proc: PROCESS
    BEGIN
        A <= '0';
        WAIT FOR 100 ns;

        A <= '1';
        WAIT FOR 100 ns;

        WAIT;
    END PROCESS;

END behavior;