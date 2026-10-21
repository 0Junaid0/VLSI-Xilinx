
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Reg_8bit IS
    PORT(
        D     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        CLK   : IN  STD_LOGIC;
        RESET : IN  STD_LOGIC;
        EN    : IN  STD_LOGIC;
        Q     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        Qn    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END Reg_8bit;

ARCHITECTURE Structural OF Reg_8bit IS

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

BEGIN

    -- Lower four bits: D(3 downto 0)
    REG_LOW : Reg_4bit
        PORT MAP(
            D => D(3 DOWNTO 0),
            CLK => CLK,
            RESET => RESET,
            EN => EN,
            Q => Q(3 DOWNTO 0),
            Qn => Qn(3 DOWNTO 0)
        );

    -- Upper four bits: D(7 downto 4)
    REG_HIGH : Reg_4bit
        PORT MAP(
            D => D(7 DOWNTO 4),
            CLK => CLK,
            RESET => RESET,
            EN => EN,
            Q => Q(7 DOWNTO 4),
            Qn => Qn(7 DOWNTO 4)
        );

END Structural;