-- MUX_4to1.vhd
-- 4-to-1 Multiplexer built structurally using three MUX_2to1 instances
-- S = "00" => D0
-- S = "01" => D1
-- S = "10" => D2
-- S = "11" => D3

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MUX_4to1 IS
    PORT(
        D0 : IN  STD_LOGIC;
        D1 : IN  STD_LOGIC;
        D2 : IN  STD_LOGIC;
        D3 : IN  STD_LOGIC;
        S  : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
        Y  : OUT STD_LOGIC
    );
END MUX_4to1;

ARCHITECTURE Structural OF MUX_4to1 IS

    COMPONENT MUX_2to1
        PORT(
            A : IN  STD_LOGIC;
            B : IN  STD_LOGIC;
            S : IN  STD_LOGIC;
            Y : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL m01 : STD_LOGIC;
    SIGNAL m23 : STD_LOGIC;

BEGIN

    -- First stage: select between D0 and D1 using S(0)
    MUX_LOW : MUX_2to1
        PORT MAP(
            A => D0,
            B => D1,
            S => S(0),
            Y => m01
        );

    -- First stage: select between D2 and D3 using S(0)
    MUX_HIGH : MUX_2to1
        PORT MAP(
            A => D2,
            B => D3,
            S => S(0),
            Y => m23
        );

    -- Second stage: select between m01 and m23 using S(1)
    MUX_OUT : MUX_2to1
        PORT MAP(
            A => m01,
            B => m23,
            S => S(1),
            Y => Y
        );

END Structural;
