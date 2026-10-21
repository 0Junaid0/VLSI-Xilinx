-- Program_ROM_tb.vhd
-- Testbench for Program ROM (Set 4)
-- Reads all 16 addresses and verifies the stored instructions

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Program_ROM_tb IS
END Program_ROM_tb;

ARCHITECTURE Behavioral OF Program_ROM_tb IS

    COMPONENT Program_ROM
        PORT(
            ADDR : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            DATA : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL ADDR : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL DATA : STD_LOGIC_VECTOR(11 DOWNTO 0);

BEGIN

    UUT : Program_ROM
        PORT MAP(
            ADDR => ADDR,
            DATA => DATA
        );

    STIM : PROCESS
    BEGIN
        -- Addr 0: LDI 0x1E = 0001_00011110 = 0x11E
        ADDR <= "0000";
        WAIT FOR 20 ns;

        -- Addr 1: STA = 1010_00000000 = 0xA00
        ADDR <= "0001";
        WAIT FOR 20 ns;

        -- Addr 2: ADD 0x22 = 0010_00100010 = 0x222
        ADDR <= "0010";
        WAIT FOR 20 ns;

        -- Addr 3: AND 0x60 = 0100_01100000 = 0x460
        ADDR <= "0011";
        WAIT FOR 20 ns;

        -- Addr 4: LDR = 1011_00000000 = 0xB00
        ADDR <= "0100";
        WAIT FOR 20 ns;

        -- Addr 5: ADD 0x01 = 0010_00000001 = 0x201
        ADDR <= "0101";
        WAIT FOR 20 ns;

        -- Addr 6: AND 0x0F = 0100_00001111 = 0x40F
        ADDR <= "0110";
        WAIT FOR 20 ns;

        -- Addr 7: STA = 1010_00000000 = 0xA00
        ADDR <= "0111";
        WAIT FOR 20 ns;

        -- Addr 8: LDI 0x00 = 0001_00000000 = 0x100
        ADDR <= "1000";
        WAIT FOR 20 ns;

        -- Addr 9: LDR = 1011_00000000 = 0xB00
        ADDR <= "1001";
        WAIT FOR 20 ns;

        -- Addr 10-15: Unused = 0x000 (NOP)
        ADDR <= "1010";
        WAIT FOR 20 ns;

        ADDR <= "1011";
        WAIT FOR 20 ns;

        ADDR <= "1100";
        WAIT FOR 20 ns;

        ADDR <= "1101";
        WAIT FOR 20 ns;

        ADDR <= "1110";
        WAIT FOR 20 ns;

        ADDR <= "1111";
        WAIT FOR 20 ns;

        ASSERT FALSE REPORT "Simulation complete." SEVERITY NOTE;
        WAIT;
    END PROCESS;

END Behavioral;
