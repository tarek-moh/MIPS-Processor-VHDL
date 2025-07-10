----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/10/2025 11:11:36 PM
-- Design Name: 
-- Module Name: ALU_tb - Behavioral
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

entity ALU_tb is
end ALU_tb;

architecture Behavioral of ALU_tb is
    signal input_1   : signed(31 downto 0) := to_signed(0, 32);
    signal input_2   : signed(31 downto 0) := to_signed(0, 32);
    signal ALUOP     : std_logic_vector(2 downto 0) := (others => '0');
    signal result    : signed(31 downto 0);
    signal zero_flag : std_logic;
begin

    -- DUT instantiation
    dut: entity work.ALU(rtl)
    port map (
        input_1   => input_1,
        input_2   => input_2,
        ALUOP     => ALUOP,
        result    => result,
        zero_flag => zero_flag
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test 1: 1 + 2 = 3
        input_1 <= to_signed(1, 32);
        input_2 <= to_signed(2, 32);
        ALUOP   <= "000";  -- ADD
        wait for 100 ns;

        -- Test 2: 7 - 3 = 4
        input_1 <= to_signed(7, 32);
        input_2 <= to_signed(3, 32);
        ALUOP   <= "001";  -- SUB
        wait for 100 ns;

        -- Test 3: 3 and 6 = 2
        input_1 <= to_signed(3, 32);  -- 0011
        input_2 <= to_signed(6, 32);  -- 0110
        ALUOP   <= "010";  -- AND
        wait for 100 ns;

        -- Test 4: 3 or 6 = 7
        input_1 <= to_signed(3, 32);
        input_2 <= to_signed(6, 32);
        ALUOP   <= "011";  -- OR
        wait for 100 ns;

        -- Test 5: SLT (2 < 3) → 1
        input_1 <= to_signed(2, 32);
        input_2 <= to_signed(3, 32);
        ALUOP   <= "100";  -- SLT    end process;
        wait for 100 ns;

        -- Test 6: SLT (5 < -1) → 0
        input_1 <= to_signed(5, 32);
        input_2 <= to_signed(-1, 32);
        ALUOP   <= "100";  -- SLT
        wait for 100 ns;

        -- Test 7: 0 + 0 = 0 → zero_flag should be 1
        input_1 <= to_signed(0, 32);
        input_2 <= to_signed(0, 32);
        ALUOP   <= "000";  -- ADD
        wait for 100 ns;

        -- Test 8: -3 - (-3) = 0 → zero_flag should be 1
        input_1 <= to_signed(-3, 32);
        input_2 <= to_signed(-3, 32);
        ALUOP   <= "001";  -- SUB
        wait for 100 ns;

        -- Test 9: AND with 0 → 0
        input_1 <= to_signed(123, 32);
        input_2 <= to_signed(0, 32);
        ALUOP   <= "010";  -- AND
        wait for 100 ns;

        -- Test 10: OR with -1 → -1
        input_1 <= to_signed(-123, 32);
        input_2 <= to_signed(-1, 32);
        ALUOP   <= "011";  -- OR
        wait for 100 ns;

        -- Test 11: SLT equal values → 0
        input_1 <= to_signed(7, 32);
        input_2 <= to_signed(7, 32);
        ALUOP   <= "100";  -- SLT
        wait;

    end process;

end Behavioral;
