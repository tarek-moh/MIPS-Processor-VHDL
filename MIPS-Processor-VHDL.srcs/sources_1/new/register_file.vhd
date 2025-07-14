----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2025 01:26:40 PM
-- Design Name: 
-- Module Name: register_file - rtl
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

entity register_file is
    Port ( read_address_1 : in STD_LOGIC_VECTOR (2 downto 0);
           read_address_2 : in STD_LOGIC_VECTOR (2 downto 0);
           write_address : in STD_LOGIC_VECTOR (2 downto 0);
           write_data : in STD_LOGIC_VECTOR (31 downto 0);
           R_rs : out STD_LOGIC_VECTOR (31 downto 0);
           R_rt : out STD_LOGIC_VECTOR (31 downto 0);
           WRITE : in STD_LOGIC;
           clk : in STD_LOGIC);
end register_file;

architecture rtl of register_file is
    type memory_array is array(0 to 7) of std_logic_vector(31 downto 0);
    signal registers : memory_array := (
    1 => X"00000005", -- r1 = 5
    2 => X"0000000A", -- r2 = 10
    4 => X"00000014", -- r4 = 20
    5 => X"00000005", -- r5 = 5
    others => (others => '0')
);
begin

    -- Read port 1
    process(registers, read_address_1)
    begin
        R_rs <= registers(to_integer(unsigned(read_address_1)));
    end process;

    -- Read port 2
    process(registers, read_address_2)
    begin
        R_rt <= registers(to_integer(unsigned(read_address_2)));
    end process;

    -- Synchronous write
    process(clk)
    begin
        if rising_edge(clk) then
            if WRITE = '1' and write_address /= "000" then
                registers(to_integer(unsigned(write_address))) <= write_data;
            end if;
        end if;
    end process;

end rtl;
