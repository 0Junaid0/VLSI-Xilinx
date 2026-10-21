
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Full_Adder_8bit_tb IS
END Full_Adder_8bit_tb;

ARCHITECTURE behavior OF Full_Adder_8bit_tb IS

    COMPONENT Full_Adder_8bit
        PORT(
            A    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            B    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            Cin  : IN  STD_LOGIC;
            Sum  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            Cout : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL A    : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
    SIGNAL B    : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
    SIGNAL Cin  : STD_LOGIC := '0';
    SIGNAL Sum  : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Cout : STD_LOGIC;

BEGIN

    UUT: Full_Adder_8bit
        PORT MAP(
            A    => A,
            B    => B,
            Cin  => Cin,
            Sum  => Sum,
            Cout => Cout
        );

    stim_proc: PROCESS
    BEGIN
        -- 30 + 34 = 64
        A <= "00011110"; B <= "00100010"; Cin <= '0';
        WAIT FOR 100 ns;

        -- 31 + 1 = 32
        A <= "00011111"; B <= "00000001"; Cin <= '0';
        WAIT FOR 100 ns;

        -- 255 + 1 = 256
        A <= "11111111"; B <= "00000001"; Cin <= '0';
        WAIT FOR 100 ns;

        -- 255 + 255 + 1 = 511
        A <= "11111111"; B <= "11111111"; Cin <= '1';
        WAIT FOR 100 ns;

        WAIT;
    END PROCESS;

END behavior;