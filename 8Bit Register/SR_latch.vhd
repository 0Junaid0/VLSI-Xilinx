library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SR_latch is
    Port (
        S_n : in STD_LOGIC;
        R_n : in STD_LOGIC;
        Q   : out STD_LOGIC;
        Qn  : out STD_LOGIC
    );
end SR_latch;

architecture Structural of SR_latch is
    component NAND_gate
        Port (
            A : in STD_LOGIC;
            B : in STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    signal q_int, qn_int : STD_LOGIC;
begin
    N1: NAND_gate port map (
        A => S_n,
        B => qn_int,
        Y => q_int
    );

    N2: NAND_gate port map (
        A => R_n,
        B => q_int,
        Y => qn_int
    );

    Q  <= q_int;
    Qn <= qn_int;
end Structural;