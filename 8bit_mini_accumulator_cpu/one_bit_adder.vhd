
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY One_Bit_Adder IS
    PORT(
        A     : IN  STD_LOGIC;
        B     : IN  STD_LOGIC;
        Sum   : OUT STD_LOGIC;
        Carry : OUT STD_LOGIC
    );
END One_Bit_Adder;

ARCHITECTURE Structural OF One_Bit_Adder IS

    COMPONENT XOR_gate
        PORT(
            A : IN  STD_LOGIC;
            B : IN  STD_LOGIC;
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

BEGIN

    U1: XOR_gate
        PORT MAP(
            A => A,
            B => B,
            Y => Sum
        );

    U2: AND_gate
        PORT MAP(
            A => A,
            B => B,
            Y => Carry
        );

END Structural;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY One_Bit_Adder IS
    PORT(
        A     : IN  STD_LOGIC;
        B     : IN  STD_LOGIC;
        Sum   : OUT STD_LOGIC;
        Carry : OUT STD_LOGIC
    );
END One_Bit_Adder;

ARCHITECTURE Structural OF One_Bit_Adder IS

    COMPONENT XOR_gate
        PORT(
            A : IN  STD_LOGIC;
            B : IN  STD_LOGIC;
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

BEGIN

    U1: XOR_gate
        PORT MAP(
            A => A,
            B => B,
            Y => Sum
        );

    U2: AND_gate
        PORT MAP(
            A => A,
            B => B,
            Y => Carry
        );

END Structural;