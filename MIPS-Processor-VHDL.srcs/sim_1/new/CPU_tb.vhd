----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/14/2025 05:39:36 PM
-- Design Name: 
-- Module Name: CPU_tb - Behavioral
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

entity CPU_tb is
--  Port ( );
end CPU_tb;

architecture Behavioral of CPU_tb is
    signal clk : std_logic := '0';
begin

-- Clock Generation
clk_process : process
begin
    while true loop
        clk <= '0'; wait for 25 ns;
        clk <= '1'; wait for 25 ns;
    end loop;
end process;

-- Instantiate CPU
UUT: entity work.CPU(rtl)
    port map (
        clk => clk
    );

-- Test sequence with assertions
test_process : process
begin
    -- Instruction 0: ADD r1 ← r2 + r3 = 10 + 5 = 15
    wait for 150 ns;
    assert registers(1) = x"0000000F"
        report "ADD failed: r1 != 15" severity error;

    -- Instruction 1: SUB r6 ← r4 - r5 = 20 - 5 = 15
    wait for 100 ns;
    assert registers(6) = x"0000000F"
        report "SUB failed: r6 != 15" severity error;

    -- Instruction 2: ADDI r2 ← r1 + 7 = 15 + 7 = 22
    wait for 100 ns;
    assert registers(2) = x"00000016"
        report "ADDI failed: r2 != 22" severity error;

    -- Instruction 3: ANDI r3 ← r2 & 0xF = 22 & 15 = 6
    wait for 100 ns;
    assert registers(3) = x"00000006"
        report "ANDI failed: r3 != 6" severity error;

    -- Instruction 4: LW r4 ← Mem[r1 + 8] = Mem[15 + 8] = Mem[23] = 99
    wait for 100 ns;
    assert registers(4) = x"00000063"
        report "LW failed: r4 != 99" severity error;

    -- Instruction 5: SW Mem[r1 + 8] ← r4 → Mem[23] = 99
    wait for 100 ns;
    assert memory(23) = x"00000063"
        report "SW failed: Mem[23] != 99" severity error;

    -- Instruction 6: BEQ r2 == r3 → r2=22, r3=6 ≠ → no branch
    wait for 100 ns;

    -- Instruction 7: NOP → r0 should still be 0
    wait for 100 ns;
    assert registers(0) = x"00000000"
        report "NOP failed: r0 changed" severity error;

    -- Instruction 8: LEA r2 ← r1 + r2*5 = 15 + 2*5 = 25
    wait for 100 ns;
    assert registers(2) = x"00000019"
        report "LEA failed: r2 != 25" severity error;

    -- Instruction 9: MVZ r3 ← r1 if r2 == 0 → false, no write
    wait for 100 ns;
    assert registers(3) = x"00000006"
        report "MVZ failed: r3 was overwritten incorrectly" severity error;

    -- Instruction 10: PCM r3 ← Mem[r2 + 4] = Mem[25 + 4] = Mem[29] = 0 (default)
    wait for 100 ns;
    assert registers(3) = x"00000000"
        report "PCM failed: r3 != Mem[r2 + 4]" severity error;

    -- Instruction 11: JUMP → PC ← 11
    wait for 100 ns;
    -- Optional: assert PC = 11 if PC is exposed

    wait;
end process;

end Behavioral;