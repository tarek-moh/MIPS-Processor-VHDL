library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder is
    Port ( x : in signed (31 downto 0);
           y : in signed (31 downto 0);
           z : out signed (31 downto 0));
end adder;

architecture rtl of adder is

begin
    
    z <= x + y;
   
end rtl;
