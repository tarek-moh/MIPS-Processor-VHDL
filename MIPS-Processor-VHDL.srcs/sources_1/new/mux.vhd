library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity mux is
    Port ( input_1 : in STD_LOGIC_VECTOR (31 downto 0);
           input_2 : in STD_LOGIC_VECTOR (31 downto 0);
           selector : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (31 downto 0));
end mux;

architecture rtl of mux is

begin

    process(input_1, input_2, selector) is 
    begin 
        
        case selector is
        when '0' => 
            output <= input_1;
        when '1' =>
            output <= input_2;
         end case;
     end process;

end rtl;
