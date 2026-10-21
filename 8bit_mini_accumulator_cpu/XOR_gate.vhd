library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity XOR_gate is
    Port (
        A : in  STD_LOGIC;
        B : in  STD_LOGIC;
        Y : out STD_LOGIC
    );
end XOR_gate;

architecture Dataflow of XOR_gate is
begin
    Y <= A xor B;
end Dataflow;