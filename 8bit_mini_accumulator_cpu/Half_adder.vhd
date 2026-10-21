
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Half_Adder IS
    PORT(
        A     : IN  STD_LOGIC;
        B     : IN  STD_LOGIC;
        Sum   : OUT STD_LOGIC;
        Carry : OUT STD_LOGIC
    );
END Half_Adder;

ARCHITECTURE Structural OF Half_Adder IS

    COMPONENT One_Bit_Adder
        PORT(
            A     : IN  STD_LOGIC;
            B     : IN  STD_LOGIC;
            Sum   : OUT STD_LOGIC;
            Carry : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN

    U1: One_Bit_Adder
        PORT MAP(
            A     => A,
            B     => B,
            Sum   => Sum,
            Carry => Carry
        );

END Structural;