LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MUX_2to1_tb IS
END MUX_2to1_tb;

ARCHITECTURE behavior OF MUX_2to1_tb IS

    COMPONENT MUX_2to1
        PORT(
            A : IN  STD_LOGIC;
            B : IN  STD_LOGIC;
            S : IN  STD_LOGIC;
            Y : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL A : STD_LOGIC := '0';
    SIGNAL B : STD_LOGIC := '0';
    SIGNAL S : STD_LOGIC := '0';
    SIGNAL Y : STD_LOGIC;

BEGIN

    uut: MUX_2to1
        PORT MAP(
            A => A,
            B => B,
            S => S,
            Y => Y
        );

    stim_proc: PROCESS
    BEGIN

        A <= '0'; B <= '0'; S <= '0';
        WAIT FOR 100 ns;

        A <= '0'; B <= '1'; S <= '0';
        WAIT FOR 100 ns;

        A <= '1'; B <= '0'; S <= '0';
        WAIT FOR 100 ns;

        A <= '1'; B <= '1'; S <= '0';
        WAIT FOR 100 ns;

        A <= '0'; B <= '0'; S <= '1';
        WAIT FOR 100 ns;

        A <= '0'; B <= '1'; S <= '1';
        WAIT FOR 100 ns;

        A <= '1'; B <= '0'; S <= '1';
        WAIT FOR 100 ns;

        A <= '1'; B <= '1'; S <= '1';
        WAIT FOR 100 ns;

        WAIT;
    END PROCESS;

END behavior;