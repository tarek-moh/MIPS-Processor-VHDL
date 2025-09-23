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
use work.cpu_definitions_pkg.all;
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
    signal registers : T_REGISTER_ARRAY;
    signal memory : T_DATA_MEMORY_ARRAY;
    signal rst : std_logic := '1';
begin

-- Clock Generation
clk_process : process
begin
    while true loop
        clk <= '0'; wait for 50 ns;
        clk <= '1'; wait for 50 ns;
    end loop;
end process;

-- Instantiate CPU
UUT: entity work.CPU(rtl)
    port map (
        rst => rst,
        clk => clk,
        debug_regs => registers,
        debug_memory => memory
    );

-- Test sequence with assertions
test_process : process
begin
    wait for 25ns;
    rst <= '0';
    
    -- Instruction 0: ADD r2, r3, r1 = 10 + 5 = 15
    wait for 100 ns;
    assert registers(1) = x"0000000F"
        report "ADD failed: r1 != 15" severity error;

    -- Instruction 1: SUB r4, r5, r6 = 20 - 5 = 15
    wait for 100 ns;
    assert registers(6) = x"0000000F"
        report "SUB failed: r6 != 15" severity error;

    -- Instruction 2: ADDI r1, r2, 7 = 15 + 7 = 22
    wait for 100 ns;
    assert registers(2) = x"00000016"
        report "ADDI failed: r2 != 22" severity error;

    -- Instruction 3: ANDI r2, r3, 0xF = 22 & 15 = 6
    wait for 100 ns;
    assert registers(3) = x"00000006"
        report "ANDI failed: r3 != 6" severity error;

    -- Instruction 4: LW r4 := Mem[r5 + 8] = Mem[5 + 8] = Mem[13] = 99
    wait for 100 ns;
    assert registers(4) = x"00000063"
        report "LW failed: r4 != 99" severity error;

    -- Instruction 5: SW Mem[r1 + 8] := r4 ; Mem[23] = 99
    wait for 100 ns;
    assert memory(23) = x"00000063"
        report "SW failed: Mem[23] != 99" severity error;

    -- Instruction 6: BEQ  if r2 == r3 ; => no branch
    wait for 100 ns;

    -- Instruction 7: NOP ; r0 should still be 0
    wait for 100 ns;
    assert registers(0) = x"00000000"
        report "NOP failed: r0 changed" severity error;

    -- Instruction 8: LEA  r2 := r5 + r2 * 5 ; 15 + 5*133 = 680
    wait for 100 ns;
    assert registers(2) = x"000002A8"
        report "LEA failed: r2 != 680 (this is due to problems with the instruction format plus ISA.)" severity error;

    -- Instruction 9: MVZ  r3 := r1 if r2==0 ; false, no write
    wait for 100 ns;
    assert registers(3) = x"00000000"
        report "MVZ failed: r3 was overwritten incorrectly" severity error;

    -- Instruction 10: PCM  r3, r7, 4  ; r7 = 10, r3 = 0 [pc should become 11 & mem[4] should become 12]
    wait for 100 ns;
    assert memory(4) = x"0000000b"
        report "PCM failed: Mem[r2 + 4] != 11" severity error;

    -- Instruction 11: JUMP 11
    wait for 100 ns;

    wait;
end process;

end Behavioral;