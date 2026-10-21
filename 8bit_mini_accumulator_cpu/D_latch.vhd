
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY D_latch IS
    PORT(
        D  : IN  STD_LOGIC;
        EN : IN  STD_LOGIC;
        Q  : OUT STD_LOGIC;
        Qn : OUT STD_LOGIC
    );
END D_latch;

ARCHITECTURE Structural OF D_latch IS

    COMPONENT NAND_gate
        PORT(
            A : IN  STD_LOGIC;
            B : IN  STD_LOGIC;
            Y : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT NOT_gate
        PORT(
            A : IN  STD_LOGIC;
            Y : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT SR_latch
        PORT(
            S_n : IN  STD_LOGIC;
            R_n : IN  STD_LOGIC;
            Q   : OUT STD_LOGIC;
            Qn  : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL D_not        : STD_LOGIC;
    SIGNAL S_n_internal : STD_LOGIC;
    SIGNAL R_n_internal : STD_LOGIC;

BEGIN

    -- Invert D using the existing NOT gate
    U_NOT : NOT_gate
        PORT MAP(
            A => D,
            Y => D_not
        );

    -- Generate active-low set signal
    U1 : NAND_gate
        PORT MAP(
            A => D,
            B => EN,
            Y => S_n_internal
        );

    -- Generate active-low reset signal
    U2 : NAND_gate
        PORT MAP(
            A => D_not,
            B => EN,
            Y => R_n_internal
        );

    -- Store the bit using the existing SR latch
    U3 : SR_latch
        PORT MAP(
            S_n => S_n_internal,
            R_n => R_n_internal,
            Q   => Q,
            Qn  => Qn
        );

END Structural;