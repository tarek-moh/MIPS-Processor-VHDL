----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/12/2025 09:09:58 PM
-- Design Name: 
-- Module Name: instruction_memory_tb - Behavioral
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

entity instruction_memory_tb is
--  Port ( );
end instruction_memory_tb;

architecture Behavioral of instruction_memory_tb is
    signal input_address : std_logic_vector(5 downto 0);
    signal instruction   : std_logic_vector(18 downto 0);
begin

    -- Instantiate DUT
    uut: entity work.instruction_memory
        port map (
            input_address => input_address,
            instruction   => instruction
        );

    -- Test process
    process
    begin
        -- Test 1: Address 0 → add r1, r2, r3
        input_address <= "000000";
        wait for 100 ns;
        assert instruction = "0000001010011000000"
            report "Test 1 Failed: Expected add r1, r2, r3" severity error;

        -- Test 2: Address 2 → addi r2, r1, #7
        input_address <= "000001";
        wait for 100 ns;
        assert instruction = "0000100101110000001"
            report "Test 2 Failed: Expected sub  r4, r5, r6" severity error;
            
        -- Done
        report "All instruction memory tests passed!" severity note;
        wait;
    end process;

end Behavioral;