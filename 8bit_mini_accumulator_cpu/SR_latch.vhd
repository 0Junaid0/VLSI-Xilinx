
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SR_latch IS
    PORT(
        S_n : IN  STD_LOGIC;
        R_n : IN  STD_LOGIC;
        Q   : OUT STD_LOGIC;
        Qn  : OUT STD_LOGIC
    );
END SR_latch;

ARCHITECTURE Structural OF SR_latch IS

    COMPONENT NAND_gate
        PORT(
            A : IN  STD_LOGIC;
            B : IN  STD_LOGIC;
            Y : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL Q_internal  : STD_LOGIC;
    SIGNAL Qn_internal : STD_LOGIC;

BEGIN

    -- NAND gate for Q
    U1 : NAND_gate
        PORT MAP(
            A => S_n,
            B => Qn_internal,
            Y => Q_internal
        );

    -- NAND gate for Qn
    U2 : NAND_gate
        PORT MAP(
            A => R_n,
            B => Q_internal,
            Y => Qn_internal
        );

    -- Connect internal signals to outputs
    Q  <= Q_internal;
    Qn <= Qn_internal;

END Structural;