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
        0 =>  "0000001010011000000", -- add  r1, r2, r3
        1 =>  "0000100101110000001", -- sub  r4, r5, r6
--        2 =>  "000101000100000111", -- addi r2, r1, #7
--        3 =>  "001001001100001111", -- andi r3, r2, #15
--        4 =>  "001101000100001000", -- lw   r4, r1, #8
--        5 =>  "010001000100001000", -- sw   r4, r1, #8
--        6 =>  "010101001100000011", -- beq  r2, r3, #3
--        7 =>  "011000000011111111", -- j    0x3F
--        8 =>  "011101001000000101", -- lea  r1, r2, #5
--        9 =>  "100001001100000000", -- mvz  r1, r2, r3
--        10 => "100101001100000100",-- pcm  r3, #4(r2)
        others => (others => '0')
    );
begin
    -- Output instruction based on address
    instruction <= ROM(to_integer(unsigned(input_address)));

end rtl;
