----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/04/2025 05:04:05 PM
-- Design Name: 
-- Module Name: PC - rtl
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
    Port ( new_address : in STD_LOGIC_VECTOR (5 downto 0);
           current_address : out STD_LOGIC_VECTOR (5 downto 0);
           clk : in STD_LOGIC);
end PC;

architecture rtl of PC is

begin

process(clk)
begin

     current_address <= new_address;

end process;

end rtl;
