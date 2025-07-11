----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2025 02:10:32 PM
-- Design Name: 
-- Module Name: control_unit_tb - Behavioral
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

entity control_unit_tb is
--  Port ( );
end control_unit_tb;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_unit_tb is
end control_unit_tb;

architecture behavioral of control_unit_tb is

    -- Signals
    signal instruction : STD_LOGIC_VECTOR (18 downto 0) := (others => '0');
    signal ALUOP       : STD_LOGIC_VECTOR (2 downto 0);
    signal REGDST, EXTD, ALUSRC, BRANCH, MEMREAD, MEMWRITE, MEMTOREG,
           REGWRITE, JUMP, LEA, MVZ, PCM : STD_LOGIC;

begin

    -- DUT Instance
    uut: entity work.control_unit
        port map (
            instruction => instruction,
            ALUOP       => ALUOP,
            REGDST      => REGDST,
            EXTD        => EXTD,
            ALUSRC      => ALUSRC,
            BRANCH      => BRANCH,
            MEMREAD     => MEMREAD,
            MEMWRITE    => MEMWRITE,
            MEMTOREG    => MEMTOREG,
            REGWRITE    => REGWRITE,
            JUMP        => JUMP,
            LEA         => LEA,
            MVZ         => MVZ,
            PCM         => PCM
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test R-type ADD (OP=0000, FUNC=000)
        instruction <= "0000000000000000000";  -- ADD
        wait for 50 ns;

        -- Test R-type SUB (OP=0000, FUNC=001)
        instruction <= "0000000000000000001";  -- SUB
        wait for 50 ns;

        -- Test R-type MVZ (OP=0000, FUNC=101)
        instruction <= "0000000000000000101";  -- MVZ
        wait for 50 ns;

        -- Test ANDI (OP=0101)
        instruction <= "0101000000000000000";  -- ANDI
        wait for 50 ns;

        -- Test ADDI (OP=0100)
        instruction <= "0100000000000000000";  -- ADDI
        wait for 50 ns;

        -- Test LW (OP=0110)
        instruction <= "0110000000000000000";  -- LW
        wait for 50 ns;

        -- Test SW (OP=1000)
        instruction <= "1000000000000000000";  -- SW
        wait for 50 ns;

        -- Test BEQ (OP=1010)
        instruction <= "1010000000000000000";  -- BEQ
        wait for 50 ns;

        -- Test LEA (OP=0111)
        instruction <= "0111000000000000000";  -- LEA
        wait for 50 ns;

        -- Test PCM (OP=1001)
        instruction <= "1001000000000000000";  -- PCM
        wait for 50 ns;

        -- Test JUMP (OP=1111)
        instruction <= "1111000000000000000";  -- JUMP
        wait for 100 ns;

        wait;
    end process;

end behavioral;


