LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Reg_1bit_tb IS
END Reg_1bit_tb;

ARCHITECTURE behavior OF Reg_1bit_tb IS

    COMPONENT Reg_1bit
    PORT(
        D   : IN STD_LOGIC;
        CLK : IN STD_LOGIC;
        Q   : OUT STD_LOGIC
    );
    END COMPONENT;

    SIGNAL D   : STD_LOGIC := '0';
    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL Q   : STD_LOGIC;

BEGIN

    uut: Reg_1bit PORT MAP (
        D   => D,
        CLK => CLK,
        Q   => Q
    );

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
        WAIT FOR 200 ns;

        WAIT;
    END PROCESS;

END behavior;