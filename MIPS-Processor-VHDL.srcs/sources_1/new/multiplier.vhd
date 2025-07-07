library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplier is
    Port (
        x : in signed(8 downto 0);  -- 9-bit signed input
        y : in signed(8 downto 0);  -- 9-bit signed input
        z : out signed(8 downto 0)  -- 9-bit signed output (truncated)
    );
end multiplier;

architecture rtl of multiplier is
    signal product_full : signed(17 downto 0);  -- Full 18-bit result before truncation
begin
    product_full <= x * y;

    -- Truncate or saturate to fit 9 bits
    z <= product_full(8 downto 0);
end rtl;
