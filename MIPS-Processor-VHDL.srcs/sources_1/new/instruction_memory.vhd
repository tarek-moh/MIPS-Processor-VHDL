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
        0 =>  "0000001010011000000",     -- add  r1, r2, r3 ; r1 = 5, r2 = 10 → r3 = 15
        1 =>  "0000100101110000001",     -- SUB  r6 ← r4 - r5      ; r4 = 20, r5 = 5 → r6 = 15
        2 =>  "0001001010000000111",     -- ADDI r2 ← r1 + 7       ; r1 = 5 → r2 = 12
        3 =>  "0010011010000001111",     -- ANDI r3 ← r2 & 0xF     ; r2 = 12 → r3 = 12
        4 =>  "0011001100000001000",     -- LW   r4 ← Mem[r1 + 8]  ; r1 = 5, mem[13] = 99 → r4 = 99
        5  => "0100001100000001000",     -- SW   Mem[r1 + 8] ← r4  ; store r4 into mem[13]
        6 =>  "0101010011000001000",     -- BEQ  if r2 == r3 → PC+3
        7 =>  "0000000000000000000",     -- nop for test
        8 =>  "0111001010000000101",     -- LEA  r2 ← r1 + r2 * 5  ; r1=5, r2=2 → r2=15
        9 =>  "1000001010011000000",         -- MVZ  r3 ← r1 if r2==0  ; r2=0, r3 = r1
        10 =>  "1001011010000000100",    -- PCM  r3 ← Mem[r2 + 4]  ; test PCM read/write
        11 => "0110000000000001011",            -- JUMP to address 11      ; force jump
        others => (others => '0')
    );
begin
    -- Output instruction based on address
    instruction <= ROM(to_integer(unsigned(input_address)));

end rtl;
