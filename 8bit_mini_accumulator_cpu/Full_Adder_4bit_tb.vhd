
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Full_Adder_4bit_tb IS
END Full_Adder_4bit_tb;

ARCHITECTURE behavior OF Full_Adder_4bit_tb IS

    COMPONENT Full_Adder_4bit
        PORT(
            A    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            Cin  : IN  STD_LOGIC;
            Sum  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            Cout : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL A    : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL B    : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL Cin  : STD_LOGIC := '0';
    SIGNAL Sum  : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Cout : STD_LOGIC;

BEGIN

    UUT: Full_Adder_4bit
        PORT MAP(
            A    => A,
            B    => B,
            Cin  => Cin,
            Sum  => Sum,
            Cout => Cout
        );

    stim_proc: PROCESS
    BEGIN
        -- 3 + 2 = 5
        A <= "0011"; B <= "0010"; Cin <= '0';
        WAIT FOR 100 ns;

        -- 7 + 8 = 15
        A <= "0111"; B <= "1000"; Cin <= '0';
        WAIT FOR 100 ns;

        -- 15 + 1 = 16
        A <= "1111"; B <= "0001"; Cin <= '0';
        WAIT FOR 100 ns;

        -- 15 + 15 + 1 = 31
        A <= "1111"; B <= "1111"; Cin <= '1';
        WAIT FOR 100 ns;

        WAIT;
    END PROCESS;

END behavior;