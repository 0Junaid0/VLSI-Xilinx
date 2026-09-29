library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NAND_gate is
    Port (
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        Y : out STD_LOGIC
    );
end NAND_gate;

architecture Dataflow of NAND_gate is
begin
    Y <= A nand B;
end Dataflow;