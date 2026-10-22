-- PC_4bit.vhd
-- 4-bit Program Counter with synchronous reset and jump support
-- Uses Reg_4bit as the base and Full_Adder_4bit for PC+1 increment

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY PC_4bit IS
    PORT(
        CLK      : IN  STD_LOGIC;
        RESET    : IN  STD_LOGIC;
        JUMP     : IN  STD_LOGIC;                        -- 1 = load jump address
        JUMP_ADDR: IN  STD_LOGIC_VECTOR(3 DOWNTO 0);     -- jump target address
        PC_OUT   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)      -- current PC value
    );
END PC_4bit;

ARCHITECTURE Structural OF PC_4bit IS

    COMPONENT Reg_4bit
        PORT(
            D     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            CLK   : IN  STD_LOGIC;
            RESET : IN  STD_LOGIC;
            EN    : IN  STD_LOGIC;
            Q     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            Qn    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Full_Adder_4bit
        PORT(
            A    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            Cin  : IN  STD_LOGIC;
            Sum  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            Cout : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT MUX_2to1
        PORT(
            A : IN  STD_LOGIC;
            B : IN  STD_LOGIC;
            S : IN  STD_LOGIC;
            Y : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL PC_current  : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL PC_plus1    : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL PC_next     : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL PC_Qn       : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL adder_cout  : STD_LOGIC;

BEGIN

    -- Incrementer: PC + 1
    U_INC : Full_Adder_4bit
        PORT MAP(
            A    => PC_current,
            B    => "0001",
            Cin  => '0',
            Sum  => PC_plus1,
            Cout => adder_cout
        );

    -- MUX: select between PC+1 (normal) and JUMP_ADDR (jump taken)
    -- JUMP=0 -> PC+1, JUMP=1 -> JUMP_ADDR
    MUX0 : MUX_2to1 PORT MAP(A => PC_plus1(0), B => JUMP_ADDR(0), S => JUMP, Y => PC_next(0));
    MUX1 : MUX_2to1 PORT MAP(A => PC_plus1(1), B => JUMP_ADDR(1), S => JUMP, Y => PC_next(1));
    MUX2 : MUX_2to1 PORT MAP(A => PC_plus1(2), B => JUMP_ADDR(2), S => JUMP, Y => PC_next(2));
    MUX3 : MUX_2to1 PORT MAP(A => PC_plus1(3), B => JUMP_ADDR(3), S => JUMP, Y => PC_next(3));

    -- PC Register: always enabled, synchronous reset
    U_REG : Reg_4bit
        PORT MAP(
            D     => PC_next,
            CLK   => CLK,
            RESET => RESET,
            EN    => '1',
            Q     => PC_current,
            Qn    => PC_Qn
        );

    -- Output the current PC
    PC_OUT <= PC_current;

END Structural;
