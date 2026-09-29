library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NOT_gate is
    Port (
        A : in STD_LOGIC;
        Y : out STD_LOGIC
    );
end NOT_gate;

architecture Dataflow of NOT_gate is
begin
    Y <= not A;
end Dataflow;