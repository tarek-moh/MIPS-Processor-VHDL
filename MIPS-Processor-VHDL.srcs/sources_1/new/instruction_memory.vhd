----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2025 12:41:48 PM
-- Design Name: 
-- Module Name: instruction_memory - Behavioral
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

entity instruction_memory is
  Port ( input_address : in std_logic_vector(5 downto 0);
         instruction : out std_logic_vector(18 downto 0)
         );
end instruction_memory;

architecture rtl of instruction_memory is

    -- Define memory type: 64 instructions, each 19 bits wide
    type memory_array is array(0 to 63) of std_logic_vector(18 downto 0);
    
    -- Hardcoded memory contents
    constant ROM : memory_array := (
        -- Format: "opcode() rs() rt() rd/imm()"
        0 => "0000000000000000001", -- fake encoding: add
        -- Remaining instructions are NOPs
        others => (others => '0')
    );
begin
    -- Output instruction based on address
    instruction <= ROM(to_integer(unsigned(input_address)));

end rtl;
