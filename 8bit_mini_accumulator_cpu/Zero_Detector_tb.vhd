-- Zero_Detector_tb.vhd
-- Testbench for 8-bit Zero Detector

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Zero_Detector_tb IS
END Zero_Detector_tb;

ARCHITECTURE Behavioral OF Zero_Detector_tb IS

    COMPONENT Zero_Detector
        PORT(
            D : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            Z : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL D : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
    SIGNAL Z : STD_LOGIC;

BEGIN

    UUT : Zero_Detector
        PORT MAP(
            D => D,
            Z => Z
        );

    STIM : PROCESS
    BEGIN
        -- Test 1: All zeros -> Z should be 1
        D <= "00000000";
        WAIT FOR 20 ns;

        -- Test 2: Only bit 0 set -> Z should be 0
        D <= "00000001";
        WAIT FOR 20 ns;

        -- Test 3: Only bit 7 set -> Z should be 0
        D <= "10000000";
        WAIT FOR 20 ns;

        -- Test 4: All ones -> Z should be 0
        D <= "11111111";
        WAIT FOR 20 ns;

        -- Test 5: 0x0F -> Z should be 0
        D <= "00001111";
        WAIT FOR 20 ns;

        -- Test 6: 0xF0 -> Z should be 0
        D <= "11110000";
        WAIT FOR 20 ns;

        -- Test 7: Back to all zeros -> Z should be 1
        D <= "00000000";
        WAIT FOR 20 ns;

        -- Test 8: 0x55 -> Z should be 0
        D <= "01010101";
        WAIT FOR 20 ns;

        ASSERT FALSE REPORT "Simulation complete." SEVERITY NOTE;
        WAIT;
    END PROCESS;

END Behavioral;
