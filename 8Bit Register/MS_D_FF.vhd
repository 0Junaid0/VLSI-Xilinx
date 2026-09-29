library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MS_D_FF is
    Port (
        D   : in STD_LOGIC;
        CLK : in STD_LOGIC;
        Q   : out STD_LOGIC;
        Qn  : out STD_LOGIC
    );
end MS_D_FF;

architecture Structural of MS_D_FF is
    component D_latch
        Port (
            D  : in STD_LOGIC;
            EN : in STD_LOGIC;
            Q  : out STD_LOGIC;
            Qn : out STD_LOGIC
        );
    end component;

    signal CLK_n : STD_LOGIC;
    signal Qm, Qmn : STD_LOGIC;
begin
    I1: entity work.NOT_gate(Dataflow)
        port map (
            A => CLK,
            Y => CLK_n
        );

    M1: D_latch
        port map (
            D  => D,
            EN => CLK_n,
            Q  => Qm,
            Qn => Qmn
        );

    S1: D_latch
        port map (
            D  => Qm,
            EN => CLK,
            Q  => Q,
            Qn => Qn
        );
end Structural;