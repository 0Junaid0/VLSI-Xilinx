library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Accumulator_1bit is
    Port (
        A     : in  STD_LOGIC;
        B     : in  STD_LOGIC;
        Cin   : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC;
        Cout  : out STD_LOGIC
    );
end Accumulator_1bit;

architecture Structural of Accumulator_1bit is

    -- 1-Bit Full Adder Component
    component Full_Adder
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            Sum  : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    end component;

    -- 1-Bit Register Component
    component Reg_1bit
        Port (
            D     : in  STD_LOGIC;
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC;
            Qn    : out STD_LOGIC
        );
    end component;

    -- Internal connection signals
    signal sum_wire : STD_LOGIC;
    signal qn_open  : STD_LOGIC;

begin

    -- 1-Bit Full Adder Instance
    FA_INST: Full_Adder
        port map (
            A    => A,
            B    => B,
            Cin  => Cin,
            Sum  => sum_wire,  -- Addition result passed to register
            Cout => Cout      -- Carry output
        );

    -- 1-Bit Register Instance
    REG_INST: Reg_1bit
        port map (
            D     => sum_wire,  -- Receives sum output from adder
            CLK   => CLK,
            RESET => RESET,
            Q     => Q,         -- Stores output on rising clock edge
            Qn    => qn_open    -- Unused inverted output
        );

end Structural;