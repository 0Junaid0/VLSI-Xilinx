LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Decoder_2to4_tb IS
END Decoder_2to4_tb;

ARCHITECTURE behavior OF Decoder_2to4_tb IS

    COMPONENT Decoder_2to4
        PORT(
            A  : IN  STD_LOGIC;
            B  : IN  STD_LOGIC;
            Y0 : OUT STD_LOGIC;
            Y1 : OUT STD_LOGIC;
            Y2 : OUT STD_LOGIC;
            Y3 : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL A  : STD_LOGIC := '0';
    SIGNAL B  : STD_LOGIC := '0';
    SIGNAL Y0 : STD_LOGIC;
    SIGNAL Y1 : STD_LOGIC;
    SIGNAL Y2 : STD_LOGIC;
    SIGNAL Y3 : STD_LOGIC;

BEGIN

    uut: Decoder_2to4 PORT MAP(
        A  => A,
        B  => B,
        Y0 => Y0,
        Y1 => Y1,
        Y2 => Y2,
        Y3 => Y3
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