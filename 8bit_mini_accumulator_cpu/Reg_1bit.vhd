
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Reg_1bit IS
    PORT(
        D     : IN  STD_LOGIC;
        CLK   : IN  STD_LOGIC;
        RESET : IN  STD_LOGIC;
        EN    : IN  STD_LOGIC;
        Q     : OUT STD_LOGIC;
        Qn    : OUT STD_LOGIC
    );
END Reg_1bit;

ARCHITECTURE Structural OF Reg_1bit IS

    COMPONENT MUX_2to1
        PORT(
            A : IN  STD_LOGIC;
            B : IN  STD_LOGIC;
            S : IN  STD_LOGIC;
            Y : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT Master_slave_d_flipflop
        PORT(
            D   : IN  STD_LOGIC;
            CLK : IN  STD_LOGIC;
            Q   : OUT STD_LOGIC;
            Qn  : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL Q_internal        : STD_LOGIC;
    SIGNAL Qn_internal       : STD_LOGIC;
    SIGNAL D_selected        : STD_LOGIC;
    SIGNAL D_selected_reset  : STD_LOGIC;

BEGIN

    -- Select new data when EN = 1,
    -- otherwise hold the current value
    U1 : MUX_2to1
        PORT MAP(
            A => Q_internal,
            B => D,
            S => EN,
            Y => D_selected
        );

    -- Select zero when RESET = 1
    U2 : MUX_2to1
        PORT MAP(
            A => D_selected,
            B => '0',
            S => RESET,
            Y => D_selected_reset
        );

    -- Store the selected data on the active clock edge
    U3 : Master_slave_d_flipflop
        PORT MAP(
            D   => D_selected_reset,
            CLK => CLK,
            Q   => Q_internal,
            Qn  => Qn_internal
        );

    -- Connect internal outputs to external ports
    Q  <= Q_internal;
    Qn <= Qn_internal;

END Structural;