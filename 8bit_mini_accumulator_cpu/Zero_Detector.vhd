-- Zero_Detector.vhd
-- 8-bit Zero Detector
-- Outputs Z = 1 when all 8 input bits are zero
-- Uses NOR tree + AND gates (structural)

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Zero_Detector IS
    PORT(
        D : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        Z : OUT STD_LOGIC
    );
END Zero_Detector;

ARCHITECTURE Structural OF Zero_Detector IS

    COMPONENT NOR_gate
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

    SIGNAL nor_01, nor_23, nor_45, nor_67 : STD_LOGIC;
    SIGNAL and_0123, and_4567             : STD_LOGIC;

BEGIN

    -- First level: NOR pairs of bits
    -- NOR(a,b) = 1 only when both a=0 and b=0
    NOR_A : NOR_gate PORT MAP(A => D(0), B => D(1), Y => nor_01);
    NOR_B : NOR_gate PORT MAP(A => D(2), B => D(3), Y => nor_23);
    NOR_C : NOR_gate PORT MAP(A => D(4), B => D(5), Y => nor_45);
    NOR_D : NOR_gate PORT MAP(A => D(6), B => D(7), Y => nor_67);

    -- Second level: AND pairs of NOR results
    AND_L : AND_gate PORT MAP(A => nor_01, B => nor_23, Y => and_0123);
    AND_H : AND_gate PORT MAP(A => nor_45, B => nor_67, Y => and_4567);

    -- Final level: AND the two halves
    AND_Z : AND_gate PORT MAP(A => and_0123, B => and_4567, Y => Z);

END Structural;
