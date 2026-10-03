library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Accumulator_4bit is
    Port (
        A     : in  STD_LOGIC_VECTOR (3 downto 0);
        B     : in  STD_LOGIC_VECTOR (3 downto 0);
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Accumulator_4bit;

architecture Structural of Accumulator_4bit is

    component Full_Adder_4bit
        Port (
            A    : IN  std_logic_vector(3 downto 0);
            B    : IN  std_logic_vector(3 downto 0);
            Cin  : IN  std_logic;
            Sum  : OUT std_logic_vector(3 downto 0);
            Cout : OUT std_logic
        );
    end component;

    component Reg_4bit
        Port (
            D     : in  STD_LOGIC_VECTOR (3 downto 0);
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR (3 downto 0);
            Qn    : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    signal sum_wire  : STD_LOGIC_VECTOR (3 downto 0);
    signal cout_wire : STD_LOGIC;
    signal qn_open   : STD_LOGIC_VECTOR (3 downto 0);

begin

    ADDER_INST: Full_Adder_4bit
        port map (
            A    => A,
            B    => B,
            Cin  => '0',
            Sum  => sum_wire,
            Cout => cout_wire
        );

    REG_INST: Reg_4bit
        port map (
            D     => sum_wire,
            CLK   => CLK,
            RESET => RESET,
            Q     => Q,
            Qn    => qn_open
        );

end Structural;