library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NOR_gate is
    Port (
        A : in  STD_LOGIC;
        B : in  STD_LOGIC;
        Y : out STD_LOGIC
    );
end NOR_gate;

architecture Dataflow of NOR_gate is
begin
    Y <= A nor B;
end Dataflow;