
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Full_Adder IS
    PORT(
        A    : IN  STD_LOGIC;
        B    : IN  STD_LOGIC;
        Cin  : IN  STD_LOGIC;
        Sum  : OUT STD_LOGIC;
        Cout : OUT STD_LOGIC
    );
END Full_Adder;

ARCHITECTURE Structural OF Full_Adder IS

    COMPONENT Half_Adder
        PORT(
            A     : IN  STD_LOGIC;
            B     : IN  STD_LOGIC;
            Sum   : OUT STD_LOGIC;
            Carry : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT OR_gate
        PORT(
            A : IN  STD_LOGIC;
            B : IN  STD_LOGIC;
            Y : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL S1 : STD_LOGIC;
    SIGNAL C1 : STD_LOGIC;
    SIGNAL C2 : STD_LOGIC;

BEGIN

    HA1: Half_Adder
        PORT MAP(
            A     => A,
            B     => B,
            Sum   => S1,
            Carry => C1
        );

    HA2: Half_Adder
        PORT MAP(
            A     => S1,
            B     => Cin,
            Sum   => Sum,
            Carry => C2
        );

    U1: OR_gate
        PORT MAP(
            A => C1,
            B => C2,
            Y => Cout
        );

END Structural;