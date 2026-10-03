library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Accumulator_4bit is
end tb_Accumulator_4bit;

architecture Behavioral of tb_Accumulator_4bit is

    component Accumulator_4bit
        Port (
            A     : in  STD_LOGIC_VECTOR (3 downto 0);
            B     : in  STD_LOGIC_VECTOR (3 downto 0);
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    signal A     : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal B     : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal CLK   : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '0';
    signal Q     : STD_LOGIC_VECTOR(3 downto 0);

    constant CLK_PERIOD : time := 20 ns;

begin

    UUT: Accumulator_4bit
        port map (
            A     => A,
            B     => B,
            CLK   => CLK,
            RESET => RESET,
            Q     => Q
        );

    CLK_PROCESS: process
    begin
        CLK <= '0';
        wait for CLK_PERIOD / 2;
        CLK <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    STIM_PROCESS: process
    begin
        -- Step 1: Synchronous Reset
        RESET <= '1';
        A     <= "0000";
        B     <= "0000";
        wait for CLK_PERIOD;

      
        RESET <= '0';
        A     <= "0011";
        B     <= "0101";
        wait for CLK_PERIOD;

      
        RESET <= '0';
        A     <= "0010";
        B     <= "0001";
        wait for CLK_PERIOD;
)
        RESET <= '0';
        A     <= "1111";
        B     <= "0001";
        wait for CLK_PERIOD;

        RESET <= '0';
        A     <= "1010";
        B     <= "0101";
        wait for CLK_PERIOD;

        wait;
    end process;

end Behavioral;