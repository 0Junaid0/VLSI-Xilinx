
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY One_Bit_Adder_tb IS
END One_Bit_Adder_tb;

ARCHITECTURE behavior OF One_Bit_Adder_tb IS

    COMPONENT One_Bit_Adder
        PORT(
            A     : IN  STD_LOGIC;
            B     : IN  STD_LOGIC;
            Sum   : OUT STD_LOGIC;
            Carry : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL A     : STD_LOGIC := '0';
    SIGNAL B     : STD_LOGIC := '0';
    SIGNAL Sum   : STD_LOGIC;
    SIGNAL Carry : STD_LOGIC;

BEGIN

    UUT: One_Bit_Adder
        PORT MAP(
            A     => A,
            B     => B,
            Sum   => Sum,
            Carry => Carry
        );

    stim_proc: PROCESS
    BEGIN
        A <= '0'; B <= '0';
        WAIT FOR 100 ns;

        A <= '0'; B <= '1';
        WAIT FOR 100 ns;

        A <= '1'; B <= '0';
        WAIT FOR 100 ns;

        A <= '1'; B <= '1';
        WAIT FOR 100 ns;

        WAIT;
    END PROCESS;

END behavior;