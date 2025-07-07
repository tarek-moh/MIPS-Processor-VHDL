library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux is
    Port (
        data_a  : in  STD_LOGIC_VECTOR(31 downto 0);
        data_b  : in  STD_LOGIC_VECTOR(31 downto 0);
        sel     : in  STD_LOGIC;
        mux_out : out STD_LOGIC_VECTOR(31 downto 0)
    );
end mux;

architecture rtl of mux is
begin
    process(data_a, data_b, sel)
    begin
        case sel is
            when '0' =>
                mux_out <= data_a;
            when '1' =>
                mux_out <= data_b;
            when others =>
                mux_out <= (others => 'X');
        end case;
    end process;
end rtl;
