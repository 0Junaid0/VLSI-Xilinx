
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Full_Adder_tb IS
END Full_Adder_tb;

ARCHITECTURE behavior OF Full_Adder_tb IS

    COMPONENT Full_Adder
        PORT(
            A    : IN  STD_LOGIC;
            B    : IN  STD_LOGIC;
            Cin  : IN  STD_LOGIC;
            Sum  : OUT STD_LOGIC;
            Cout : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL A    : STD_LOGIC := '0';
    SIGNAL B    : STD_LOGIC := '0';
    SIGNAL Cin  : STD_LOGIC := '0';
    SIGNAL Sum  : STD_LOGIC;
    SIGNAL Cout : STD_LOGIC;

BEGIN

    UUT: Full_Adder
        PORT MAP(
            A    => A,
            B    => B,
            Cin  => Cin,
            Sum  => Sum,
            Cout => Cout
        );

    stim_proc: PROCESS
    BEGIN
        A <= '0'; B <= '0'; Cin <= '0';
        WAIT FOR 100 ns;

        A <= '0'; B <= '0'; Cin <= '1';
        WAIT FOR 100 ns;

        A <= '0'; B <= '1'; Cin <= '0';
        WAIT FOR 100 ns;

        A <= '0'; B <= '1'; Cin <= '1';
        WAIT FOR 100 ns;

        A <= '1'; B <= '0'; Cin <= '0';
        WAIT FOR 100 ns;

        A <= '1'; B <= '0'; Cin <= '1';
        WAIT FOR 100 ns;

        A <= '1'; B <= '1'; Cin <= '0';
        WAIT FOR 100 ns;

        A <= '1'; B <= '1'; Cin <= '1';
        WAIT FOR 100 ns;

        WAIT;
    END PROCESS;

END behavior;