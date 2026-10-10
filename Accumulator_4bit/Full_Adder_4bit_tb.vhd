LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Full_Adder_4bit_tb IS
END Full_Adder_4bit_tb;

ARCHITECTURE behavior OF Full_Adder_4bit_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Full_Adder_4bit
    PORT(
        A    : IN  std_logic_vector(3 downto 0);
        B    : IN  std_logic_vector(3 downto 0);
        Cin  : IN  std_logic;
        Sum  : OUT std_logic_vector(3 downto 0);
        Cout : OUT std_logic
    );
    END COMPONENT;

    -- Inputs
    signal A   : std_logic_vector(3 downto 0) := "0000";
    signal B   : std_logic_vector(3 downto 0) := "0000";
    signal Cin : std_logic := '0';

    -- Outputs
    signal Sum  : std_logic_vector(3 downto 0);
    signal Cout : std_logic;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: Full_Adder_4bit PORT MAP (
        A    => A,
        B    => B,
        Cin  => Cin,
        Sum  => Sum,
        Cout => Cout
    );

    -- Stimulus process
    stim_proc: process
    begin

        -- Test 1: 0 + 0 + 0 = 0
        A <= "0000";
        B <= "0000";
        Cin <= '0';
        wait for 100 ns;

        -- Test 2: 1 + 1 + 0 = 2
        A <= "0001";
        B <= "0001";
        Cin <= '0';
        wait for 100 ns;

        -- Test 3: 5 + 3 + 0 = 8
        A <= "0101";
        B <= "0011";
        Cin <= '0';
        wait for 100 ns;

        -- Test 4: 7 + 4 + 0 = 11
        A <= "0111";
        B <= "0100";
        Cin <= '0';
        wait for 100 ns;

        -- Test 5: 10 + 5 + 0 = 15
        A <= "1010";
        B <= "0101";
        Cin <= '0';
        wait for 100 ns;

        -- Test 6: 10 + 5 + 1 = 16
        -- Expected Sum = 0000
        -- Expected Cout = 1
        A <= "1010";
        B <= "0101";
        Cin <= '1';
        wait for 100 ns;

        -- Test 7: 15 + 1 + 0 = 16
        -- Expected Sum = 0000
        -- Expected Cout = 1
        A <= "1111";
        B <= "0001";
        Cin <= '0';
        wait for 100 ns;

        -- Test 8: 15 + 15 + 1 = 31
        -- Expected Sum = 1111
        -- Expected Cout = 1
        A <= "1111";
        B <= "1111";
        Cin <= '1';
        wait for 100 ns;

        -- Stop simulation
        wait;

    end process;

END behavior;