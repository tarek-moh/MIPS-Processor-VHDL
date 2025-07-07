library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_tb is
end mux_tb;

architecture behavioral of mux_tb is
    signal data_a  : STD_LOGIC_VECTOR(31 downto 0);
    signal data_b  : STD_LOGIC_VECTOR(31 downto 0);
    signal sel     : STD_LOGIC;
    signal mux_out : STD_LOGIC_VECTOR(31 downto 0);
begin

    uut: entity work.mux(rtl)
    port map (
        data_a  => data_a,
        data_b  => data_b,
        sel     => sel,
        mux_out => mux_out
    );

    -- Optional stimulus process for simulation
    stimulus: process
    begin
        data_a <= x"AAAAAAAA";
        data_b <= x"55555555";

        sel <= '0';
        wait for 100 ns;
        sel <= '1';
        wait for 100 ns;
        data_b <= x"BBBBBBBB";
        wait for 100 ns;
                sel <= 'Z';  -- undefined, should produce 'X's in output
        wait;
    end process;

end behavioral;
