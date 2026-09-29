LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MS_D_FF_tb IS
END MS_D_FF_tb;

ARCHITECTURE behavior OF MS_D_FF_tb IS

    COMPONENT MS_D_FF
    PORT(
        D   : IN STD_LOGIC;
        CLK : IN STD_LOGIC;
        Q   : OUT STD_LOGIC;
        Qn  : OUT STD_LOGIC
    );
    END COMPONENT;

    SIGNAL D   : STD_LOGIC := '0';
    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL Q   : STD_LOGIC;
    SIGNAL Qn  : STD_LOGIC;

BEGIN

    uut: MS_D_FF PORT MAP (
        D   => D,
        CLK => CLK,
        Q   => Q,
        Qn  => Qn
    );

    -- Clock generation
    clk_process: PROCESS
    BEGIN
        CLK <= '0';
        WAIT FOR 50 ns;
        CLK <= '1';
        WAIT FOR 50 ns;
    END PROCESS;

    stim_proc: PROCESS
    BEGIN
        D <= '0';
        WAIT FOR 100 ns;

        D <= '1';
        WAIT FOR 100 ns;

        D <= '0';
        WAIT FOR 100 ns;

        D <= '1';
        WAIT FOR 100 ns;

        D <= '1';
        WAIT FOR 100 ns;

        WAIT;
    END PROCESS;

END behavior;