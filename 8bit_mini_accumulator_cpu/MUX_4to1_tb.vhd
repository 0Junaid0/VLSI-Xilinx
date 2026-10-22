-- MUX_4to1_tb.vhd
-- Testbench for MUX_4to1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MUX_4to1_tb IS
END MUX_4to1_tb;

ARCHITECTURE Behavioral OF MUX_4to1_tb IS

    COMPONENT MUX_4to1
        PORT(
            D0 : IN  STD_LOGIC;
            D1 : IN  STD_LOGIC;
            D2 : IN  STD_LOGIC;
            D3 : IN  STD_LOGIC;
            S  : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
            Y  : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL D0 : STD_LOGIC := '1';
    SIGNAL D1 : STD_LOGIC := '0';
    SIGNAL D2 : STD_LOGIC := '1';
    SIGNAL D3 : STD_LOGIC := '0';
    SIGNAL S  : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL Y  : STD_LOGIC;

BEGIN

    UUT : MUX_4to1
        PORT MAP(
            D0 => D0,
            D1 => D1,
            D2 => D2,
            D3 => D3,
            S  => S,
            Y  => Y
        );

    STIM : PROCESS
    BEGIN
        -- Test S=00 -> should output D0 (1)
        S <= "00";
        WAIT FOR 20 ns;

        -- Test S=01 -> should output D1 (0)
        S <= "01";
        WAIT FOR 20 ns;

        -- Test S=10 -> should output D2 (1)
        S <= "10";
        WAIT FOR 20 ns;

        -- Test S=11 -> should output D3 (0)
        S <= "11";
        WAIT FOR 20 ns;

        -- Invert inputs and test again
        D0 <= '0'; D1 <= '1'; D2 <= '0'; D3 <= '1';
        S <= "00"; WAIT FOR 20 ns;
        S <= "01"; WAIT FOR 20 ns;
        S <= "10"; WAIT FOR 20 ns;
        S <= "11"; WAIT FOR 20 ns;

        ASSERT FALSE REPORT "Simulation complete." SEVERITY NOTE;
        WAIT;
    END PROCESS;

END Behavioral;
