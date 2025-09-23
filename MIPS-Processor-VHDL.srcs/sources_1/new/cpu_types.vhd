----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/21/2025 06:13:11 PM
-- Design Name: 
-- Module Name: cpu_types - Behavioral
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

package cpu_definitions_pkg is
    
    -- Type for the 8-entry, 32-bit register file
    type T_REGISTER_ARRAY is array(0 to 7) of std_logic_vector(31 downto 0);
    
    -- Type for the data memory (e.g., 64 entries x 32 bits)
    type T_DATA_MEMORY_ARRAY is array(0 to 63) of std_logic_vector(31 downto 0);

end package cpu_definitions_pkg;
