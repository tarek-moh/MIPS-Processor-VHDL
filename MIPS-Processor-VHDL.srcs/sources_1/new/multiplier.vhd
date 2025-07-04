library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplier is
    Port ( x : in signed (31 downto 0);
           y : in signed (31 downto 0);
           z : out signed (31 downto 0));
end multiplier;

architecture rtl of multiplier is

begin
   
    z <= x * y;

end rtl;
