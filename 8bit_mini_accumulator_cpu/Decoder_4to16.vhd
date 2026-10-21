
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Decoder_4to16 IS
    PORT(
        A : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        Y : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END Decoder_4to16;

ARCHITECTURE Structural OF Decoder_4to16 IS

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

    COMPONENT AND_gate
        PORT(
            A : IN  STD_LOGIC;
            B : IN  STD_LOGIC;
            Y : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL E0, E1, E2, E3 : STD_LOGIC;
    SIGNAL L0, L1, L2, L3 : STD_LOGIC;

BEGIN

    -- Decode the upper two input bits
    U_HIGH : Decoder_2to4
        PORT MAP(
            A  => A(3),
            B  => A(2),
            Y0 => E0,
            Y1 => E1,
            Y2 => E2,
            Y3 => E3
        );

    -- Decode the lower two input bits
    U_LOW : Decoder_2to4
        PORT MAP(
            A  => A(1),
            B  => A(0),
            Y0 => L0,
            Y1 => L1,
            Y2 => L2,
            Y3 => L3
        );

    -- Output group 0: addresses 0 to 3
    G0 : AND_gate PORT MAP(A => E0, B => L0, Y => Y(0));
    G1 : AND_gate PORT MAP(A => E0, B => L1, Y => Y(1));
    G2 : AND_gate PORT MAP(A => E0, B => L2, Y => Y(2));
    G3 : AND_gate PORT MAP(A => E0, B => L3, Y => Y(3));

    -- Output group 1: addresses 4 to 7
    G4 : AND_gate PORT MAP(A => E1, B => L0, Y => Y(4));
    G5 : AND_gate PORT MAP(A => E1, B => L1, Y => Y(5));
    G6 : AND_gate PORT MAP(A => E1, B => L2, Y => Y(6));
    G7 : AND_gate PORT MAP(A => E1, B => L3, Y => Y(7));

    -- Output group 2: addresses 8 to 11
    G8  : AND_gate PORT MAP(A => E2, B => L0, Y => Y(8));
    G9  : AND_gate PORT MAP(A => E2, B => L1, Y => Y(9));
    G10 : AND_gate PORT MAP(A => E2, B => L2, Y => Y(10));
    G11 : AND_gate PORT MAP(A => E2, B => L3, Y => Y(11));

    -- Output group 3: addresses 12 to 15
    G12 : AND_gate PORT MAP(A => E3, B => L0, Y => Y(12));
    G13 : AND_gate PORT MAP(A => E3, B => L1, Y => Y(13));
    G14 : AND_gate PORT MAP(A => E3, B => L2, Y => Y(14));
    G15 : AND_gate PORT MAP(A => E3, B => L3, Y => Y(15));

END Structural;