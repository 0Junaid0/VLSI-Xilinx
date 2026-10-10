LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Full_Adder_tb IS
END Full_Adder_tb;

ARCHITECTURE behavior OF Full_Adder_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Full_Adder
    PORT(
        A    : IN  std_logic;
        B    : IN  std_logic;
        Cin  : IN  std_logic;
        SUM  : OUT std_logic;
        COUT : OUT std_logic
    );
    END COMPONENT;

    -- Inputs
    signal A   : std_logic := '0';
    signal B   : std_logic := '0';
    signal Cin : std_logic := '0';

    -- Outputs
    signal SUM  : std_logic;
    signal COUT : std_logic;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: Full_Adder PORT MAP(
        A    => A,
        B    => B,
        Cin  => Cin,
        SUM  => SUM,
        COUT => COUT
    );

    -- Stimulus process
    stim_proc: process
    begin

        -- Test 1: 0 + 0 + 0
        A <= '0';
        B <= '0';
        Cin <= '0';
        wait for 100 ns;

        -- Test 2: 0 + 0 + 1
        A <= '0';
        B <= '0';
        Cin <= '1';
        wait for 100 ns;

        -- Test 3: 0 + 1 + 0
        A <= '0';
        B <= '1';
        Cin <= '0';
        wait for 100 ns;

        -- Test 4: 0 + 1 + 1
        A <= '0';
        B <= '1';
        Cin <= '1';
        wait for 100 ns;

        -- Test 5: 1 + 0 + 0
        A <= '1';
        B <= '0';
        Cin <= '0';
        wait for 100 ns;

        -- Test 6: 1 + 0 + 1
        A <= '1';
        B <= '0';
        Cin <= '1';
        wait for 100 ns;

        -- Test 7: 1 + 1 + 0
        A <= '1';
        B <= '1';
        Cin <= '0';
        wait for 100 ns;

        -- Test 8: 1 + 1 + 1
        A <= '1';
        B <= '1';
        Cin <= '1';
        wait for 100 ns;

        -- Stop simulation
        wait;

    end process;

END behavior;