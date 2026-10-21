LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY AND_gate_tb IS
END AND_gate_tb;

ARCHITECTURE behavior OF AND_gate_tb IS

    COMPONENT AND_gate
    PORT(
        A : IN STD_LOGIC;
        B : IN STD_LOGIC;
        Y : OUT STD_LOGIC
    );
    END COMPONENT;

    SIGNAL A : STD_LOGIC := '0';
    SIGNAL B : STD_LOGIC := '0';
    SIGNAL Y : STD_LOGIC;

BEGIN

    uut: AND_gate PORT MAP (
        A => A,
        B => B,
        Y => Y
    );

    stim_proc: PROCESS
    BEGIN
        A <= '0'; B <= '0';
        WAIT FOR 100 ns;

        A <= '0'; B <= '1';
        WAIT FOR 100 ns;

        A <= '1'; B <= '0';
        WAIT FOR 100 ns;

        A <= '1'; B <= '1';
        WAIT FOR 100 ns;

        WAIT;
    END PROCESS;

END behavior;