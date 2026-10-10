LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Full_Adder_4bit IS
    PORT(
        A    : IN  std_logic_vector(3 downto 0);
        B    : IN  std_logic_vector(3 downto 0);
        Cin  : IN  std_logic;
        Sum  : OUT std_logic_vector(3 downto 0);
        Cout : OUT std_logic
    );
END Full_Adder_4bit;

ARCHITECTURE Structural OF Full_Adder_4bit IS

    -- Component declaration
    COMPONENT Full_Adder
    PORT(
        A    : IN  std_logic;
        B    : IN  std_logic;
        Cin  : IN  std_logic;
        Sum  : OUT std_logic;
        Cout : OUT std_logic
    );
    END COMPONENT;

    -- Carry signals
    signal C : std_logic_vector(4 downto 0);

BEGIN

    -- Initial carry
    C(0) <= Cin;

    -- Bit 0
    FA0: Full_Adder
    PORT MAP(
        A    => A(0),
        B    => B(0),
        Cin  => C(0),
        Sum  => Sum(0),
        Cout => C(1)
    );

    -- Bit 1
    FA1: Full_Adder
    PORT MAP(
        A    => A(1),
        B    => B(1),
        Cin  => C(1),
        Sum  => Sum(1),
        Cout => C(2)
    );

    -- Bit 2
    FA2: Full_Adder
    PORT MAP(
        A    => A(2),
        B    => B(2),
        Cin  => C(2),
        Sum  => Sum(2),
        Cout => C(3)
    );

    -- Bit 3
    FA3: Full_Adder
    PORT MAP(
        A    => A(3),
        B    => B(3),
        Cin  => C(3),
        Sum  => Sum(3),
        Cout => C(4)
    );

    -- Final carry
    Cout <= C(4);

END Structural;