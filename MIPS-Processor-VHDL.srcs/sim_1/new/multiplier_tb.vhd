library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplier_tb is
end multiplier_tb;

architecture Behavioral of multiplier_tb is

    -- Component under test signals
    signal x : signed(8 downto 0) := (others => '0');
    signal y : signed(8 downto 0) := (others => '0');
    signal z : signed(8 downto 0);

begin

    -- Instantiate the multiplier
    uut: entity work.multiplier(rtl)
        port map (
            x => x,
            y => y,
            z => z
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test case 1: 5 * 3
        x <= to_signed(5, 9);
        y <= to_signed(3, 9);
        wait for 100 ns;

        -- Test case 2: -5 * 3
        x <= to_signed(-5, 9);
        y <= to_signed(3, 9);
        wait for 100 ns;

        -- Test case 3: -7 * -2
        x <= to_signed(-7, 9);
        y <= to_signed(-2, 9);
        wait for 100 ns;

        -- Test case 4: 127 * 2 (overflow for 9-bit output)
        x <= to_signed(127, 9);
        y <= to_signed(2, 9);
        wait for 100 ns;

        -- Test case 5: 0 * -42
        x <= to_signed(0, 9);
        y <= to_signed(-42, 9);
        wait for 100 ns;

        -- Done
        wait;
    end process;

end Behavioral;
