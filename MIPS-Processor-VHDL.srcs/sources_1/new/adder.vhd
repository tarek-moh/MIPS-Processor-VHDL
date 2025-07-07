library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder is
    Port ( x : in signed (5 downto 0);
           y : in signed (5 downto 0);
           z : out signed (5 downto 0));
end adder;

architecture rtl of adder is
signal sum_full: signed(6 downto 0);
begin
    sum_full <= resize(x, 7) + resize(y, 7);  -- Resize both to 7 bits
    z <= sum_full(5 downto 0);               -- Truncate to 6 bits
end rtl;
