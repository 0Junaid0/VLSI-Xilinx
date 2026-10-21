
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Decoder_4to16_tb IS
END Decoder_4to16_tb;

ARCHITECTURE behavior OF Decoder_4to16_tb IS

    COMPONENT Decoder_4to16
        PORT(
            A : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            Y : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL A : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL Y : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN

    UUT : Decoder_4to16
        PORT MAP(
            A => A,
            Y => Y
        );

    stim_proc : PROCESS
    BEGIN
        A <= "0000"; WAIT FOR 100 ns;
        A <= "0001"; WAIT FOR 100 ns;
        A <= "0010"; WAIT FOR 100 ns;
        A <= "0011"; WAIT FOR 100 ns;

        A <= "0100"; WAIT FOR 100 ns;
        A <= "0101"; WAIT FOR 100 ns;
        A <= "0110"; WAIT FOR 100 ns;
        A <= "0111"; WAIT FOR 100 ns;

        A <= "1000"; WAIT FOR 100 ns;
        A <= "1001"; WAIT FOR 100 ns;
        A <= "1010"; WAIT FOR 100 ns;
        A <= "1011"; WAIT FOR 100 ns;

        A <= "1100"; WAIT FOR 100 ns;
        A <= "1101"; WAIT FOR 100 ns;
        A <= "1110"; WAIT FOR 100 ns;
        A <= "1111"; WAIT FOR 100 ns;

        WAIT;
    END PROCESS;

END behavior;