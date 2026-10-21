
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Reg_4bit IS
    PORT(
        D     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        CLK   : IN  STD_LOGIC;
        RESET : IN  STD_LOGIC;
        EN    : IN  STD_LOGIC;
        Q     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Qn    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END Reg_4bit;

ARCHITECTURE Structural OF Reg_4bit IS

    COMPONENT Reg_1bit
        PORT(
            D     : IN  STD_LOGIC;
            CLK   : IN  STD_LOGIC;
            RESET : IN  STD_LOGIC;
            EN    : IN  STD_LOGIC;
            Q     : OUT STD_LOGIC;
            Qn    : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN

    REG0 : Reg_1bit
        PORT MAP(
            D     => D(0),
            CLK   => CLK,
            RESET => RESET,
            EN    => EN,
            Q     => Q(0),
            Qn    => Qn(0)
        );

    REG1 : Reg_1bit
        PORT MAP(
            D     => D(1),
            CLK   => CLK,
            RESET => RESET,
            EN    => EN,
            Q     => Q(1),
            Qn    => Qn(1)
        );

    REG2 : Reg_1bit
        PORT MAP(
            D     => D(2),
            CLK   => CLK,
            RESET => RESET,
            EN    => EN,
            Q     => Q(2),
            Qn    => Qn(2)
        );

    REG3 : Reg_1bit
        PORT MAP(
            D     => D(3),
            CLK   => CLK,
            RESET => RESET,
            EN    => EN,
            Q     => Q(3),
            Qn    => Qn(3)
        );

END Structural;