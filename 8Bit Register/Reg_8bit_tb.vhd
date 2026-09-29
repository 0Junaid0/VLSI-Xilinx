LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Reg_8bit_tb IS
END Reg_8bit_tb;

ARCHITECTURE behavior OF Reg_8bit_tb IS

    COMPONENT Reg_8bit
    PORT(
        D   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        CLK : IN STD_LOGIC;
        Q   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    END COMPONENT;

    SIGNAL D   : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL Q   : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

    uut: Reg_8bit PORT MAP (
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
        D <= "00000000";
        WAIT FOR 100 ns;

        D <= "00000001";
        WAIT FOR 100 ns;

        D <= "10101010";
        WAIT FOR 100 ns;

        D <= "11111111";
        WAIT FOR 100 ns;

        D <= "01010101";
        WAIT FOR 100 ns;

        D <= "11001100";
        WAIT FOR 100 ns;

        D <= "00000000";
        WAIT FOR 100 ns;

        WAIT;
    END PROCESS;

END behavior;