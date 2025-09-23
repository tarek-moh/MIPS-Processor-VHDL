----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2025 01:01:36 PM
-- Design Name: 
-- Module Name: data_memory - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity data_memory is
  Port ( 
        write_address : in std_logic_vector(31 downto 0);
        read_address : in std_logic_vector(31 downto 0);
        write_data : in std_logic_vector(31 downto 0);
        MEMREAD : in std_logic;
        MEMWRITE : in std_logic;
        debug_mem : out T_DATA_MEMORY_ARRAY;
        data : out std_logic_vector(31 downto 0)
  );
end data_memory;

architecture rtl of data_memory is
    signal memory : T_DATA_MEMORY_ARRAY  := (
    13 => X"00000063", -- mem[13] = 99 (for lw test)
    15 =>  X"0000000b", -- mem[1] = 11 for PCM testing
    others => (others => '0')
);
begin
    debug_mem <= memory;
    -- Combinational Read
    process(read_address, MEMREAD, memory)
    begin
        if MEMREAD = '1' then
            data <= memory(to_integer(unsigned(read_address(5 downto 0))));
        else
            data <= (others => 'Z');  
        end if;
    end process;

    -- Synchronous Write
    process(write_address, write_data, MEMWRITE)
    begin
        if MEMWRITE = '1' then
            memory(to_integer(unsigned(write_address(5 downto 0)))) <= write_data;
        end if;
    end process;

    
end rtl;
