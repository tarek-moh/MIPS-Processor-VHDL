----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/13/2025 08:10:26 PM
-- Design Name: 
-- Module Name: mux_1bit - Behavioral
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

entity mux_1bit is
    port (
        data_a    : in  std_logic;
        data_b    : in  std_logic;
        sel  : in  std_logic;
        mux_out : out std_logic
    );
end entity;

architecture rtl of mux_1bit is
    signal temp_a, temp_b, result : std_logic_vector(0 downto 0);
begin
    temp_a(0) <= data_a;
    temp_b(0) <= data_b;

    mux_core : entity work.mux
        generic map (N => 1)
        port map (
            data_a => temp_a,
            data_b => temp_b,
            sel    => sel,
            mux_out => result
        );

    mux_out <= result(0);
end rtl;
