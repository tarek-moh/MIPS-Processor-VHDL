----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/12/2025 08:53:04 PM
-- Design Name: 
-- Module Name: data_memory_tb - Behavioral
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

entity data_memory_tb is
--  Port ( );
end data_memory_tb;
architecture Behavioral of data_memory_tb is
    -- Component Under Test (CUT) signals
    signal write_address : std_logic_vector(31 downto 0);
    signal read_address  : std_logic_vector(31 downto 0);
    signal write_data    : std_logic_vector(31 downto 0);
    signal MEMREAD       : std_logic := '0';
    signal MEMWRITE      : std_logic := '0';
    signal data          : std_logic_vector(31 downto 0);
begin

    -- Instantiate the data_memory module
    uut: entity work.data_memory
        port map (
            write_address => write_address,
            read_address  => read_address,
            write_data    => write_data,
            MEMREAD       => MEMREAD,
            MEMWRITE      => MEMWRITE,
            data          => data
        );

    stimulus: process
    begin
        -- Test 1: Write data to address 5, then read it back
        write_address <= x"00000005";
        write_data    <= x"DEADBEEF";
        MEMWRITE      <= '1';
        wait for 100 ns;

        MEMWRITE <= '0';
        read_address <= x"00000005";
        MEMREAD <= '1';
        wait for 100 ns;

        assert data = x"DEADBEEF"
            report "Test 1 Failed: Data at address 5 should be DEADBEEF" severity error;

        MEMREAD <= '0';
        wait for 100 ns;

        -- Test 2: Write to address 10, then read it back
        write_address <= x"0000000A";
        write_data    <= x"12345678";
        MEMWRITE      <= '1';
        wait for 100 ns;

        MEMWRITE <= '0';
        read_address <= x"0000000A";
        MEMREAD <= '1';
        wait for 100 ns;

        assert data = x"12345678"
            report "Test 2 Failed: Data at address 10 should be 12345678" severity error;

        MEMREAD <= '0';
        wait for 100 ns;

        -- Test 3: Read with MEMREAD = '0' (should output high-impedance)
        read_address <= x"00000005";
        MEMREAD <= '0';
        wait for 100 ns;

        for i in data'range loop
            assert data(i) = 'Z'
                report "Test 3 Failed: data(" & integer'image(i) & ") is not 'Z' when MEMREAD = 0"
                severity error;
        end loop;

        -- Test 4: Attempt write with MEMWRITE = '0' (should not update memory)
        write_address <= x"0000000F";
        write_data    <= x"FFFFFFFF";
        MEMWRITE      <= '0';  -- Disabled write
        wait for 100 ns;

        read_address <= x"0000000F";
        MEMREAD <= '1';
        wait for 100 ns;

        assert data = x"00000000"
            report "Test 4 Failed: Write was disabled, memory at address 15 should remain 0" severity error;

        -- Test Complete
        report "All data_memory tests passed!" severity note;
        wait;
    end process;

end Behavioral;