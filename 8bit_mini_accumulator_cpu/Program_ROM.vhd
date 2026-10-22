-- Program_ROM.vhd
-- 16 x 12-bit Program ROM for Set 4: LDI, ADD, STA, LDR, AND
-- Pure structural implementation using Decoder_4to16 and OR_gate tree
--
-- Set 4 Program:
--   Addr 0: LDI 0x1E  => 0001_00011110 = 0x11E
--   Addr 1: STA       => 1010_00000000 = 0xA00
--   Addr 2: ADD 0x22  => 0010_00100010 = 0x222
--   Addr 3: AND 0x60  => 0100_01100000 = 0x460
--   Addr 4: LDR       => 1011_00000000 = 0xB00
--   Addr 5: ADD 0x01  => 0010_00000001 = 0x201
--   Addr 6: AND 0x0F  => 0100_00001111 = 0x40F
--   Addr 7: STA       => 1010_00000000 = 0xA00
--   Addr 8: LDI 0x00  => 0001_00000000 = 0x100
--   Addr 9: LDR       => 1011_00000000 = 0xB00
--   Addr 10-15: 0x000 (NOP)
--
-- Word bit equations (active high from address lines w(0) to w(15)):
--   Bit 0  = w(5) or w(6)
--   Bit 1  = w(0) or w(2) or w(6)
--   Bit 2  = w(0) or w(6)
--   Bit 3  = w(0) or w(6)
--   Bit 4  = w(0)
--   Bit 5  = w(2) or w(3)
--   Bit 6  = w(3)
--   Bit 7  = '0'
--   Bit 8  = w(0) or w(4) or w(8) or w(9)
--   Bit 9  = w(1) or w(2) or w(4) or w(5) or w(7) or w(9)
--   Bit 10 = w(3) or w(6)
--   Bit 11 = w(1) or w(4) or w(7) or w(9)

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Program_ROM IS
    PORT(
        ADDR : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        DATA : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
    );
END Program_ROM;

ARCHITECTURE Structural OF Program_ROM IS

    COMPONENT Decoder_4to16
        PORT(
            A : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            Y : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT OR_gate
        PORT(
            A : IN  STD_LOGIC;
            B : IN  STD_LOGIC;
            Y : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL w : STD_LOGIC_VECTOR(15 DOWNTO 0);

    -- Intermediate OR signals for bit 1
    SIGNAL b1_02 : STD_LOGIC;

    -- Intermediate OR signals for bit 8
    SIGNAL b8_04 : STD_LOGIC;
    SIGNAL b8_89 : STD_LOGIC;

    -- Intermediate OR signals for bit 9
    SIGNAL b9_12 : STD_LOGIC;
    SIGNAL b9_45 : STD_LOGIC;
    SIGNAL b9_79 : STD_LOGIC;
    SIGNAL b9_1245 : STD_LOGIC;

    -- Intermediate OR signals for bit 11
    SIGNAL b11_14 : STD_LOGIC;
    SIGNAL b11_79 : STD_LOGIC;

    -- Shared sub-terms
    SIGNAL w0_or_w6 : STD_LOGIC;

BEGIN

    -- 1. Decode PC address into 16 active-high word lines
    U_DEC : Decoder_4to16
        PORT MAP(
            A => ADDR,
            Y => w
        );

    -- Bit 0 = w(5) or w(6)
    U_B0 : OR_gate PORT MAP(A => w(5), B => w(6), Y => DATA(0));

    -- Shared w(0) or w(6) used by Bit 2 and Bit 3
    U_W06 : OR_gate PORT MAP(A => w(0), B => w(6), Y => w0_or_w6);
    DATA(2) <= w0_or_w6;
    DATA(3) <= w0_or_w6;

    -- Bit 1 = w(0) or w(2) or w(6) = (w(0) or w(2)) or w(6)
    U_B1_A : OR_gate PORT MAP(A => w(0), B => w(2), Y => b1_02);
    U_B1_B : OR_gate PORT MAP(A => b1_02, B => w(6), Y => DATA(1));

    -- Bit 4 = w(0)
    DATA(4) <= w(0);

    -- Bit 5 = w(2) or w(3)
    U_B5 : OR_gate PORT MAP(A => w(2), B => w(3), Y => DATA(5));

    -- Bit 6 = w(3)
    DATA(6) <= w(3);

    -- Bit 7 = '0'
    DATA(7) <= '0';

    -- Bit 8 = w(0) or w(4) or w(8) or w(9)
    U_B8_A : OR_gate PORT MAP(A => w(0), B => w(4), Y => b8_04);
    U_B8_B : OR_gate PORT MAP(A => w(8), B => w(9), Y => b8_89);
    U_B8_C : OR_gate PORT MAP(A => b8_04, B => b8_89, Y => DATA(8));

    -- Bit 9 = w(1) or w(2) or w(4) or w(5) or w(7) or w(9)
    U_B9_A : OR_gate PORT MAP(A => w(1), B => w(2), Y => b9_12);
    U_B9_B : OR_gate PORT MAP(A => w(4), B => w(5), Y => b9_45);
    U_B9_C : OR_gate PORT MAP(A => w(7), B => w(9), Y => b9_79);
    U_B9_D : OR_gate PORT MAP(A => b9_12, B => b9_45, Y => b9_1245);
    U_B9_E : OR_gate PORT MAP(A => b9_1245, B => b9_79, Y => DATA(9));

    -- Bit 10 = w(3) or w(6)
    U_B10 : OR_gate PORT MAP(A => w(3), B => w(6), Y => DATA(10));

    -- Bit 11 = w(1) or w(4) or w(7) or w(9)
    U_B11_A : OR_gate PORT MAP(A => w(1), B => w(4), Y => b11_14);
    U_B11_B : OR_gate PORT MAP(A => w(7), B => w(9), Y => b11_79);
    U_B11_C : OR_gate PORT MAP(A => b11_14, B => b11_79, Y => DATA(11));

END Structural;
