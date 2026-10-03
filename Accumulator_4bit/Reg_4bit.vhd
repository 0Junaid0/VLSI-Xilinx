library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg_4bit is
    Port (
        D     : in  STD_LOGIC_VECTOR (3 downto 0);
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC_VECTOR (3 downto 0);
        Qn    : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Reg_4bit;

architecture Structural of Reg_4bit is

    component Reg_1bit
        Port (
            D     : in  STD_LOGIC;
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC;
            Qn    : out STD_LOGIC
        );
    end component;

begin

    REG0: Reg_1bit port map (D => D(0), CLK => CLK, RESET => RESET, Q => Q(0), Qn => Qn(0));
    REG1: Reg_1bit port map (D => D(1), CLK => CLK, RESET => RESET, Q => Q(1), Qn => Qn(1));
    REG2: Reg_1bit port map (D => D(2), CLK => CLK, RESET => RESET, Q => Q(2), Qn => Qn(2));
    REG3: Reg_1bit port map (D => D(3), CLK => CLK, RESET => RESET, Q => Q(3), Qn => Qn(3));

end Structural;