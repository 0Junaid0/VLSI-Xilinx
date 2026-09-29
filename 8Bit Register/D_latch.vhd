library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_latch is
    Port (
        D  : in STD_LOGIC;
        EN : in STD_LOGIC;
        Q  : out STD_LOGIC;
        Qn : out STD_LOGIC
    );
end D_latch;

architecture Structural of D_latch is
    component NAND_gate
        Port (
            A : in STD_LOGIC;
            B : in STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    component NOT_gate
        Port (
            A : in STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    signal Dn, Sn, Rn : STD_LOGIC;
begin
    I1: NOT_gate port map (
        A => D,
        Y => Dn
    );

    N1: NAND_gate port map (
        A => D,
        B => EN,
        Y => Sn
    );

    N2: NAND_gate port map (
        A => Dn,
        B => EN,
        Y => Rn
    );

    L1: entity work.SR_latch(Structural)
        port map (
            S_n => Sn,
            R_n => Rn,
            Q   => Q,
            Qn  => Qn
        );
end Structural;