library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg_1bit is
    Port (
        D   : in STD_LOGIC;
        CLK : in STD_LOGIC;
        Q   : out STD_LOGIC
    );
end Reg_1bit;

architecture Structural of Reg_1bit is
    component MS_D_FF
        Port (
            D   : in STD_LOGIC;
            CLK : in STD_LOGIC;
            Q   : out STD_LOGIC;
            Qn  : out STD_LOGIC
        );
    end component;

    signal Qn_unused : STD_LOGIC;
begin
    F1: MS_D_FF
        port map (
            D   => D,
            CLK => CLK,
            Q   => Q,
            Qn  => Qn_unused
        );
end Structural;