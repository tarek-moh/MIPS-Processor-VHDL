----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/06/2025 09:49:20 PM
-- Design Name: 
-- Module Name: extender_tb - Behavioral
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

entity extender_tb is
--  Port ( );
end extender_tb;

architecture Behavioral of extender_tb is
    signal extend_in  : std_logic_vector(8 downto 0);
    signal extend_out : std_logic_vector(31 downto 0);
    signal EXTD      : std_logic := '0';
begin
    
    uut : entity work.extender(rtl)
    port map(
        input => extend_in,
        output => extend_out,
        EXTD => EXTD
    );
    
    process is
    begin
        extend_in <= "101010000";
        wait for 100 ns;
        EXTD <= '1';
        wait for 100 ns;
        EXTD <= 'Z';
        wait;
    end process;

end Behavioral;
