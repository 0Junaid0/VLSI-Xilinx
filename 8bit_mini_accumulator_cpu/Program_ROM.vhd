-- Program_ROM.vhd
-- 16 x 12-bit Program ROM for Set 4: LDI, ADD, STA, LDR, AND
-- Combinational read (no clock needed), addressed by PC[3:0]
-- Unused addresses contain 0x000 (NOP)

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Program_ROM IS
    PORT(
        ADDR : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        DATA : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
    );
END Program_ROM;

ARCHITECTURE Behavioral OF Program_ROM IS
BEGIN

    -- Set 4 test program from Appendix B
    -- Encoding: instr[11:8] = opcode, instr[7:0] = operand
    -- LDI=0001, ADD=0010, AND=0100, STA=1010, LDR=1011

    PROCESS(ADDR)
    BEGIN
        CASE ADDR IS
            -- Addr 0: LDI 0x1E  => 0001_00011110 = 0x11E
            WHEN "0000" => DATA <= "000100011110";
            -- Addr 1: STA       => 1010_00000000 = 0xA00
            WHEN "0001" => DATA <= "101000000000";
            -- Addr 2: ADD 0x22  => 0010_00100010 = 0x222
            WHEN "0010" => DATA <= "001000100010";
            -- Addr 3: AND 0x60  => 0100_01100000 = 0x460
            WHEN "0011" => DATA <= "010001100000";
            -- Addr 4: LDR       => 1011_00000000 = 0xB00
            WHEN "0100" => DATA <= "101100000000";
            -- Addr 5: ADD 0x01  => 0010_00000001 = 0x201
            WHEN "0101" => DATA <= "001000000001";
            -- Addr 6: AND 0x0F  => 0100_00001111 = 0x40F
            WHEN "0110" => DATA <= "010000001111";
            -- Addr 7: STA       => 1010_00000000 = 0xA00
            WHEN "0111" => DATA <= "101000000000";
            -- Addr 8: LDI 0x00  => 0001_00000000 = 0x100
            WHEN "1000" => DATA <= "000100000000";
            -- Addr 9: LDR       => 1011_00000000 = 0xB00
            WHEN "1001" => DATA <= "101100000000";
            -- Unused addresses: NOP (0x000)
            WHEN OTHERS => DATA <= "000000000000";
        END CASE;
    END PROCESS;

END Behavioral;
