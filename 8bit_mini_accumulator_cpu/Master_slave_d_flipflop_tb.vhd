
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Master_slave_d_flipflop_tb IS
END Master_slave_d_flipflop_tb;

ARCHITECTURE behavior OF Master_slave_d_flipflop_tb IS

    COMPONENT Master_slave_d_flipflop
        PORT(
            D   : IN  STD_LOGIC;
            CLK : IN  STD_LOGIC;
            Q   : OUT STD_LOGIC;
            Qn  : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL D   : STD_LOGIC := '0';
    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL Q   : STD_LOGIC;
    SIGNAL Qn  : STD_LOGIC;

BEGIN

    UUT : Master_slave_d_flipflop
        PORT MAP(
            D   => D,
            CLK => CLK,
            Q   => Q,
            Qn  => Qn
        );

    -- Clock period = 100 ns
    CLK <= NOT CLK AFTER 50 ns;

    stim_proc : PROCESS
    BEGIN

        -- Data = 1 before the rising edge at 50 ns
        D <= '1';
        WAIT FOR 100 ns;

        -- Data = 0 before the next rising edge at 150 ns
        D <= '0';
        WAIT FOR 100 ns;

        -- Data = 1 before the next rising edge at 250 ns
        D <= '1';
        WAIT FOR 100 ns;

        -- Data = 0 before the next rising edge at 350 ns
        D <= '0';
        WAIT FOR 100 ns;

        WAIT;
    END PROCESS;

END behavior;