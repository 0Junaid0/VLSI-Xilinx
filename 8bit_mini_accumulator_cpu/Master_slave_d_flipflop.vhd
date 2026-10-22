
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Master_slave_d_flipflop IS
    PORT(
        D   : IN  STD_LOGIC;
        CLK : IN  STD_LOGIC;
        Q   : OUT STD_LOGIC;
        Qn  : OUT STD_LOGIC
    );
END Master_slave_d_flipflop;

ARCHITECTURE Structural OF Master_slave_d_flipflop IS

    COMPONENT D_latch
        PORT(
            D  : IN  STD_LOGIC;
            EN : IN  STD_LOGIC;
            Q  : OUT STD_LOGIC;
            Qn : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT NOT_gate
        PORT(
            A : IN  STD_LOGIC;
            Y : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL CLK_NOT : STD_LOGIC;
    SIGNAL MASTER_Q : STD_LOGIC;
    SIGNAL MASTER_QN : STD_LOGIC;
    SIGNAL SLAVE_QN : STD_LOGIC;

BEGIN

    -- Invert the clock for the master latch
    U1 : NOT_gate
        PORT MAP(
            A => CLK,
            Y => CLK_NOT
        );

    -- Master latch is enabled while CLK = 0
    U2 : D_latch
        PORT MAP(
            D  => D,
            EN => CLK_NOT,
            Q  => MASTER_Q,
            Qn => MASTER_QN
        );

    -- Slave latch is enabled while CLK = 1
    U3 : D_latch
        PORT MAP(
            D  => MASTER_Q,
            EN => CLK,
            Q  => Q,
            Qn => SLAVE_QN
        );

    Qn <= SLAVE_QN;

END Structural;