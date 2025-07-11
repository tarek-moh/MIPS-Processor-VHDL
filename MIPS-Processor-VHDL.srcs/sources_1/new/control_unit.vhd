----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2025 01:51:10 PM
-- Design Name: 
-- Module Name: control_unit - rtl
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

entity control_unit is
    Port ( instruction : in STD_LOGIC_VECTOR (18 downto 0);
           ALUOP : out STD_LOGIC_VECTOR (2 downto 0);
           REGDST : out STD_LOGIC;
           EXTD : out STD_LOGIC;
           ALUSRC : out STD_LOGIC;
           BRANCH : out STD_LOGIC;
           MEMREAD : out STD_LOGIC;
           MEMWRITE : out STD_LOGIC;
           MEMTOREG : out STD_LOGIC;
           REGWRITE : out STD_LOGIC;
           JUMP : out STD_LOGIC;
           LEA : out STD_LOGIC;
           MVZ : out STD_LOGIC;
           PCM : out STD_LOGIC);
end control_unit;

architecture rtl of control_unit is

begin

    process(instruction)
    variable OP   : std_logic_vector(3 downto 0);
    variable FUNC : std_logic_vector(2 downto 0);
    
    begin
        OP   := instruction(18 downto 15);
        FUNC := instruction(2 downto 0);

        -- default values
        ALUOP     <= "000";
        REGDST    <= '0';
        EXTD      <= '0';
        ALUSRC    <= '0';
        BRANCH    <= '0';
        MEMREAD   <= '0';
        MEMWRITE  <= '0';
        MEMTOREG  <= '0';
        REGWRITE  <= '0';
        JUMP      <= '0';
        LEA       <= '0';
        MVZ       <= '0';
        PCM       <= '0';

        if OP = "0000" then  -- R-type
            case FUNC is
                when "000" =>  -- add
                    ALUOP    <= "000";
                    REGDST   <= '1';
                    REGWRITE <= '1';
                when "001" =>  -- sub
                    ALUOP    <= "001";
                    REGDST   <= '1';
                    REGWRITE <= '1';
                when "010" =>  -- and
                    ALUOP    <= "010";
                    REGDST   <= '1';
                    REGWRITE <= '1';
                when "011" =>  -- or
                    ALUOP    <= "011";
                    REGDST   <= '1';
                    REGWRITE <= '1';
                when "100" =>  -- slt
                    ALUOP    <= "100";
                    REGDST   <= '1';
                    REGWRITE <= '1';
                when "101" =>  -- mvz
                    ALUOP    <= "001";
                    REGDST   <= '1';
                    REGWRITE <= '1';
                    MVZ      <= '1';
                when others =>
                    null;
            end case;

        else  -- I-type and others
            case OP is
                when "0101" =>  -- andi
                    ALUOP    <= "010";
                    EXTD     <= '0';
                    ALUSRC   <= '1';
                    REGWRITE <= '1';

                when "0100" =>  -- addi
                    ALUOP    <= "000";
                    EXTD     <= '1';
                    ALUSRC   <= '1';
                    REGWRITE <= '1';

                when "0110" =>  -- lw
                    ALUOP     <= "000";
                    EXTD      <= '1';
                    ALUSRC    <= '1';
                    MEMREAD   <= '1';
                    MEMTOREG  <= '1';
                    REGWRITE  <= '1';

                when "1000" =>  -- sw
                    ALUOP     <= "000";
                    EXTD      <= '1';
                    ALUSRC    <= '1';
                    MEMWRITE  <= '1';

                when "1010" =>  -- beq
                    ALUOP    <= "001";
                    EXTD     <= '1';
                    BRANCH   <= '1';

                when "0111" =>  -- lea
                    ALUOP    <= "000";
                    EXTD     <= '1';
                    ALUSRC   <= '1';
                    REGWRITE <= '1';
                    LEA      <= '1';

                when "1001" =>  -- pcm
                    ALUOP     <= "000";
                    EXTD      <= '1';
                    ALUSRC    <= '1';
                    MEMREAD   <= '1';
                    MEMWRITE  <= '1';
                    MEMTOREG  <= '1';
                    PCM       <= '1';

                when "1111" =>  -- j
                    REGWRITE <= '1';
                    JUMP     <= '1';

                when others =>
                    null;
            end case;
        end if;
    end process;

end rtl;
