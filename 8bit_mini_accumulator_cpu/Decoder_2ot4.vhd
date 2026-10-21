LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Decoder_2to4 IS
    PORT(
        A  : IN  STD_LOGIC;
        B  : IN  STD_LOGIC;
        Y0 : OUT STD_LOGIC;
        Y1 : OUT STD_LOGIC;
        Y2 : OUT STD_LOGIC;
        Y3 : OUT STD_LOGIC
    );
END Decoder_2to4;

ARCHITECTURE Structural OF Decoder_2to4 IS

    COMPONENT NOT_gate
        PORT(
            A : IN  STD_LOGIC;
            Y : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT AND_gate
        PORT(
            A : IN  STD_LOGIC;
            B : IN  STD_LOGIC;
            Y : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL A_NOT : STD_LOGIC;
    SIGNAL B_NOT : STD_LOGIC;

BEGIN

    -- Invert both inputs
    U1: NOT_gate PORT MAP(A => A, Y => A_NOT);
    U2: NOT_gate PORT MAP(A => B, Y => B_NOT);

    -- Generate the four output combinations
    U3: AND_gate PORT MAP(A => A_NOT, B => B_NOT, Y => Y0);
    U4: AND_gate PORT MAP(A => A_NOT, B => B,     Y => Y1);
    U5: AND_gate PORT MAP(A => A,     B => B_NOT, Y => Y2);
    U6: AND_gate PORT MAP(A => A,     B => B,     Y => Y3);

END Structural;