library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    generic (
        N : integer := 32  -- Default width is 32 bits
    );
    port (
        data_a  : in  std_logic_vector(N - 1 downto 0);
        data_b  : in  std_logic_vector(N - 1 downto 0);
        sel     : in  std_logic;
        mux_out : out std_logic_vector(N - 1 downto 0)
    );
end entity;

architecture rtl of mux is
begin
    mux_out <= data_a when sel = '0' else data_b;
end architecture;
