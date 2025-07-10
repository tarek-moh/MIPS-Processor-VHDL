----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/10/2025 11:02:37 PM
-- Design Name: 
-- Module Name: ALU - rtl
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

entity ALU is
    Port (
        input_1   : in  signed(31 downto 0);
        input_2   : in  signed(31 downto 0);
        ALUOP     : in  std_logic_vector(2 downto 0);
        result    : out signed(31 downto 0);
        zero_flag : out std_logic
    );
end ALU;

architecture rtl of ALU is
begin
    process(input_1, input_2, ALUOP)
        variable temp_result : signed(31 downto 0);
    begin
        case ALUOP is
            when "000" =>  -- ADD
                temp_result := input_1 + input_2;
            when "001" =>  -- SUB
                temp_result := input_1 - input_2;
            when "010" =>  -- AND
                temp_result := input_1 and input_2;
            when "011" =>  -- OR
                temp_result := input_1 or input_2;
            when "100" =>  -- SLT
                if input_1 < input_2 then
                    temp_result := to_signed(1, 32);
                else
                    temp_result := to_signed(0, 32);
                end if;
            when others =>
                temp_result := (others => '0');
        end case;

        result <= temp_result;
        if temp_result = to_signed(0,32) then
            zero_flag <= '1';
        else
            zero_flag <= '0';
        end if;
    end process;
end rtl;