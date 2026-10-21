
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Full_Adder_8bit IS
    PORT(
        A    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        B    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        Cin  : IN  STD_LOGIC;
        Sum  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        Cout : OUT STD_LOGIC
    );
END Full_Adder_8bit;

ARCHITECTURE Structural OF Full_Adder_8bit IS

    COMPONENT Full_Adder_4bit
        PORT(
            A    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            Cin  : IN  STD_LOGIC;
            Sum  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            Cout : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL C4 : STD_LOGIC;

BEGIN

    -- Lower 4-bit adder: bits 0 to 3
    FA_LOW: Full_Adder_4bit
        PORT MAP(
            A    => A(3 DOWNTO 0),
            B    => B(3 DOWNTO 0),
            Cin  => Cin,
            Sum  => Sum(3 DOWNTO 0),
            Cout => C4
        );

    -- Upper 4-bit adder: bits 4 to 7
    FA_HIGH: Full_Adder_4bit
        PORT MAP(
            A    => A(7 DOWNTO 4),
            B    => B(7 DOWNTO 4),
            Cin  => C4,
            Sum  => Sum(7 DOWNTO 4),
            Cout => Cout
        );

END Structural;