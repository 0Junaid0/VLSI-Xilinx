LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Full_Adder IS
    PORT(
        A    : IN  std_logic;
        B    : IN  std_logic;
        Cin  : IN  std_logic;
        SUM  : OUT std_logic;
        COUT : OUT std_logic
    );
END Full_Adder;


ARCHITECTURE Structural OF Full_Adder IS

    -- XOR gate component
    COMPONENT XOR_gate
    PORT(
        A : IN  std_logic;
        B : IN  std_logic;
        Y : OUT std_logic
    );
    END COMPONENT;

    -- AND gate component
    COMPONENT AND_gate
    PORT(
        A : IN  std_logic;
        B : IN  std_logic;
        Y : OUT std_logic
    );
    END COMPONENT;

    -- OR gate component
    COMPONENT OR_gate
    PORT(
        A : IN  std_logic;
        B : IN  std_logic;
        Y : OUT std_logic
    );
    END COMPONENT;

    -- Intermediate signals
    signal X1 : std_logic;
    signal A1 : std_logic;
    signal A2 : std_logic;

BEGIN

    -- XOR1: A XOR B
    XOR1: XOR_gate
    PORT MAP(
        A => A,
        B => B,
        Y => X1
    );

    -- XOR2: (A XOR B) XOR Cin
    XOR2: XOR_gate
    PORT MAP(
        A => X1,
        B => Cin,
        Y => SUM
    );

    -- AND1: A AND B
    AND1: AND_gate
    PORT MAP(
        A => A,
        B => B,
        Y => A1
    );

    -- AND2: Cin AND (A XOR B)
    AND2: AND_gate
    PORT MAP(
        A => Cin,
        B => X1,
        Y => A2
    );

    -- OR: A1 OR A2
    OR1: OR_gate
    PORT MAP(
        A => A1,
        B => A2,
        Y => COUT
    );

END Structural;