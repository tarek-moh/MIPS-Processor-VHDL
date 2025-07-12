----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/12/2025 08:12:19 PM
-- Design Name: 
-- Module Name: register_file_tb - Behavioral
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

entity register_file_tb is
--  Port ( );
end register_file_tb;

architecture Behavioral of register_file_tb is
    signal read_address_1 : STD_LOGIC_VECTOR (2 downto 0);
    signal read_address_2 : STD_LOGIC_VECTOR (2 downto 0);
    signal write_address : STD_LOGIC_VECTOR (2 downto 0);
    signal write_data : STD_LOGIC_VECTOR (31 downto 0);
    signal R_rs : STD_LOGIC_VECTOR (31 downto 0);
    signal R_rt : STD_LOGIC_VECTOR (31 downto 0);
    signal WRITE : STD_LOGIC := '0';
    signal clk : STD_LOGIC := '0';
begin

    -- DUT instantiation
    registers: entity work.register_file(rtl)
        port map (
            read_address_1 => read_address_1,
            read_address_2 => read_address_2,
            write_address   => write_address,
            write_data      => write_data,
            R_rs            => R_rs,
            R_rt            => R_rt,
            WRITE           => WRITE,
            clk             => clk
        );

    -- Clock generation
    clk_process : process
    begin
        wait for 50 ns;
        clk <= not clk;
    end process;

    -- Test process
    stimulus_process : process
    begin
        -- 1. Read register 0 and 1 (uninitialized)
        read_address_1 <= "000"; -- R_rs
        read_address_2 <= "001"; -- R_rt
        WRITE <= '0';
        wait for 100 ns;

        assert R_rs = X"00000000"
            report "Register 0 (R_rs) should be 0 at reset." severity error;
        assert R_rt = X"00000000"
            report "Register 1 (R_rt) should be 0 before write." severity error;

        -- 2. Write value to register 1
        write_address <= "001";
        write_data <= X"01111111";
        WRITE <= '1';
        wait for 100 ns;

        -- Disable write, then read from register 1
        WRITE <= '0';
        read_address_1 <= "001";
        wait for 100 ns;

        assert R_rs = X"01111111"
            report "Register 1 (R_rs) should contain 0x01111111 after write." severity error;

        -- 3. Try to write to register 0 (should not change)
        write_address <= "000";
        write_data <= X"AAAAAAAA";
        WRITE <= '1';
        wait for 100 ns;

        WRITE <= '0';
        read_address_1 <= "000";
        wait for 100 ns;

        assert R_rs = X"00000000"
            report "Register 0 (R_rs) should remain 0; writing to R0 must have no effect." severity error;

        -- 4. Attempt to write with WRITE = 0 (should have no effect)
        write_address <= "111";
        write_data <= X"DEADBEEF";
        WRITE <= '0';
        wait for 100 ns;

        -- Read register 7
        read_address_1 <= "111";
        wait for 100 ns;

        assert R_rs = X"00000000"
            report "Register 7 (R_rs) should be 0; WRITE signal was low." severity error;

        wait;
    end process;

end Behavioral;

