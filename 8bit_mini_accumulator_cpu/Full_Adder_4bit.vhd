
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Full_Adder_4bit IS
    PORT(
        A    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        Cin  : IN  STD_LOGIC;
        Sum  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Cout : OUT STD_LOGIC
    );
END Full_Adder_4bit;

ARCHITECTURE Structural OF Full_Adder_4bit IS

    COMPONENT Full_Adder
        PORT(
            A    : IN  STD_LOGIC;
            B    : IN  STD_LOGIC;
            Cin  : IN  STD_LOGIC;
            Sum  : OUT STD_LOGIC;
            Cout : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL C : STD_LOGIC_VECTOR(4 DOWNTO 0);

BEGIN

    C(0) <= Cin;

    FA0: Full_Adder
        PORT MAP(
            A    => A(0),
            B    => B(0),
            Cin  => C(0),
            Sum  => Sum(0),
            Cout => C(1)
        );

    FA1: Full_Adder
        PORT MAP(
            A    => A(1),
            B    => B(1),
            Cin  => C(1),
            Sum  => Sum(1),
            Cout => C(2)
        );

    FA2: Full_Adder
        PORT MAP(
            A    => A(2),
            B    => B(2),
            Cin  => C(2),
            Sum  => Sum(2),
            Cout => C(3)
        );

    FA3: Full_Adder
        PORT MAP(
            A    => A(3),
            B    => B(3),
            Cin  => C(3),
            Sum  => Sum(3),
            Cout => C(4)
        );

    Cout <= C(4);

END Structural;