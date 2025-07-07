----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/07/2025 10:40:38 PM
-- Design Name: 
-- Module Name: adder_tb - Behavioral
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

entity adder_tb is
--  Port ( );
end adder_tb;

architecture Behavioral of adder_tb is
    signal x,y,z : signed(5 downto 0);
    
begin
    
    -- instantiate UUT 
    uut : entity work.adder(rtl)
    port map(
        x => x,
        y => y,
        z => z
    );
    
    stim_process : process
        begin
        -- 5 + 6 = 11
        x <= to_signed(5,6);
        y <= to_signed(6,6);
        wait for 100 ns;
        
        -- 5 + -6 = -1
        x <= to_signed(5,6);
        y <= to_signed(-6,6);
        wait for 100 ns;  
        
        -- 31 + 31 = 62 (overflow) expected -2
        x <= to_signed(31,6);
        y <= to_signed(31,6);
        wait for 100 ns; 
     end process;
end Behavioral;
