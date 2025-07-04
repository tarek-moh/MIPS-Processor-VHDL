----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/04/2025 03:47:27 PM
-- Design Name: 
-- Module Name: extender - rtl
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity extender is
    Port ( input : in STD_LOGIC_VECTOR (8 downto 0);
           output : out STD_LOGIC_VECTOR (31 downto 0);
           EXTD : in STD_LOGIC);
end extender;

architecture rtl of extender is

begin
    
    process is
    begin
        if EXTD = '0' then
            output <= std_logic_vector(resize(unsigned(input), output'length));
        elsif EXTD = '1' then
            output <= std_logic_vector(resize(signed(input), output'length));
        else 
            output <= X"00000000";
        end if;
    end process;
end rtl;
