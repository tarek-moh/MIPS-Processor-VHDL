----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/13/2025 07:06:47 PM
-- Design Name: 
-- Module Name: CPU - rtl
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

entity CPU is
    Port ( clk : in STD_LOGIC);
end CPU;

architecture rtl of CPU is

--== FETCH SIGNALS ==--
    signal current_address, new_address, pc_plus_1 : std_logic_vector(5 downto 0) := "000000";
    signal instruction : std_logic_vector(18 downto 0);
    signal z_internal : signed(5 downto 0);
    
--== DECODE SIGNALS ==--
     
     signal ALUOP : STD_LOGIC_VECTOR(2 downto 0) := "000";
     signal REGDST, EXTD, ALUSRC, BRANCH, MEMREAD, MEMWRITE, MEMTOREG, REGWRITE, JUMP, LEA, MVZ, PCM : std_logic := '0';
     signal rs : std_logic_vector(2 downto 0) := instruction(14 downto 12);
     signal rt : std_logic_vector(2 downto 0) := instruction(11 downto 9);
     signal rd : std_logic_vector(2 downto 0) := instruction(8 downto 6);
     signal imm : std_logic_vector(8 downto 0) := instruction(8 downto 0);
     signal jump_address : std_logic_vector(11 downto 0) := instruction(11 downto 0);

     signal write_address : STD_LOGIC_VECTOR (2 downto 0);
     signal R_rs : STD_LOGIC_VECTOR (31 downto 0);
     signal R_rt : STD_LOGIC_VECTOR (31 downto 0);
     signal mux_reg_write : STD_LOGIC;
     signal reg_write_data, write_back_data : STD_LOGIC_VECTOR (31 downto 0);
     
--== EXECUTE SIGNALS ==--
     signal mult_result_internal : signed(8 downto 0);
     signal mult_result : STD_LOGIC_VECTOR ( 8 downto 0);
     signal extender_input : STD_LOGIC_VECTOR ( 8 downto 0);
     signal extender_out, alu_input_1, alu_input_2 : STD_LOGIC_VECTOR ( 31 downto 0);
     signal alu_result_internal : signed(31 downto 0);
     signal alu_result : STD_LOGIC_VECTOR(31 downto 0);
     signal branch_sel, zero_flag : STD_LOGIC;
     signal pc_1_to_2, pc_2_to_3 : STD_LOGIC_VECTOR (5 downto 0);
--== MEMORY SIGNALS ==--
     signal extended_pc_plus_1, memory_read_address, memory_write_data, memory_dout : STD_LOGIC_VECTOR(31 downto 0);
begin

--=== FETCH STAGE ===--
    PCReg: entity work.pc(rtl)
     port map(clk => clk, current_address => current_address, new_address => new_address);
    
    InstrMem: entity work.instruction_memory(rtl)
     port map(input_address => current_address, instruction => instruction);
     
    adder : entity work.adder(rtl)
    port map( x => "000001", y => signed(current_address), z => z_internal);
    pc_plus_1 <= std_logic_vector(z_internal);

    --=== DECODE STAGE ===--
    ControlUnitInst: entity work.control_unit(rtl)
     port map(
        instruction => instruction,
        REGDST => REGDST,
        EXTD => EXTD,
        ALUSRC => ALUSRC,
        BRANCH => BRANCH,
        MEMREAD => MEMREAD,
        MEMWRITE => MEMWRITE,
        MEMTOREG => MEMTOREG,
        REGWRITE => REGWRITE,
        JUMP => JUMP,
        LEA => LEA,
        MVZ => MVZ,
        PCM => PCM
    );
    
    write_addr_mux : entity work.mux(rtl)
    generic map(
    N => 3
    )
    port map(
    data_a => rt,
    data_b => rd,
    sel => REGDST,
    mux_out => write_address
    );
    
    regwrite_mux : entity work.mux_1bit(rtl)
    port map(
        data_a => REGWRITE,  
        data_b =>  zero_flag,
        sel => MVZ,
        mux_out => mux_reg_write
    );

    RegFile: entity work.register_file(rtl)
     port map(
        read_address_1 => rs,
        read_address_2 => rt,
        write_address => write_address,
        write_data => reg_write_data,
        R_rs => R_rs,
        R_rt => R_rt,
        WRITE => mux_reg_write,
        clk => clk
    );
    
    --=== EXECUTE STAGE ===--
    multiplier : entity work.multiplier
    port map(
    x => signed(R_rt(8 downto 0)),
    y => signed(imm),
    z => mult_result_internal
    );
    
    mult_result <= std_logic_vector(mult_result_internal);
    
    
    LEA_mux : entity work.mux(rtl)
    generic map(
    N => 9
    )
    port map(
    data_a => imm,
    data_b => mult_result,
    sel => LEA,
    mux_out => extender_input
    );
    
    extender : entity work.extender(rtl)
    port map(
    input => extender_input,
    output => extender_out,
    EXTD => EXTD
    );
    
    alu_mux_1 : entity work.mux(rtl)
    generic map(
    N => 32
    )
    port map(
    data_a => R_rs,
    data_b => X"00000000",
    sel => MVZ,
    mux_out => alu_input_1
    );
    
    alu_mux_2 : entity work.mux(rtl)
    generic map(
    N => 32
    )
    port map(
    data_a  => R_rt,
    data_b  => extender_out,
    sel     => ALUSRC,
    mux_out => alu_input_2
    );
    
    
    
    ALU: entity work.ALU(rtl)
    port map (
        input_1   => signed(alu_input_1),
        input_2   => signed(alu_input_2),
        ALUOP     => ALUOP,
        result    => alu_result_internal,
        zero_flag => zero_flag
    );
    
    alu_result <= std_logic_VECTOR(alu_result_internal);
    
    branch_sel <= BRANCH and zero_flag;
    
    pc_mux_1 : entity work.mux(rtl)
    generic map(
    N => 6
    )
    port map(
    data_a  => pc_plus_1,
    data_b  => instruction(5 downto 0),
    sel     => branch_sel,
    mux_out => pc_1_to_2
    );
    
    
    pc_mux_2 : entity work.mux(rtl)
    generic map(
    N => 6
    )
    port map(
    data_a  => pc_1_to_2,
    data_b  => memory_dout(5 downto 0),
    sel     => PCM,
    mux_out => pc_2_to_3
    );
    
    pc_mux_3 : entity work.mux(rtl)
    generic map(
    N => 6
    )
    port map(
    data_a  => pc_2_to_3,
    data_b  => instruction(5 downto 0),
    sel     => JUMP,
    mux_out => new_address
    );
    
    --=== MEMORY STAGE ===--
    read_addr_mux : entity work.mux(rtl)
    generic map(
    N => 32
    )
    port map(
    data_a => alu_result,
    data_b => R_rt,
    sel => PCM,
    mux_out => memory_read_address
    );
    
    
    write_data_mux : entity work.mux(rtl)
    generic map(
    N => 32
    )
    port map(
    data_a => R_rt,
    data_b => extended_pc_plus_1,
    sel => PCM,
    mux_out => memory_write_data
    );
    
    
    DataMemory : entity work.data_memory
        port map (
            write_address => alu_result,
            read_address  => memory_read_address,
            write_data    => memory_write_data,
            MEMREAD       => MEMREAD,
            MEMWRITE      => MEMWRITE,
            data          => memory_dout
        );
    --=== WRITEBACK STAGE ===--
    Mux_WriteBack: entity work.mux(rtl)
    generic map(
    N => 32
    )
    port map(
    data_a => memory_dout,
    data_b => alu_result,
    sel => MEMTOREG,
    mux_out => write_back_data
    );
    
    Mux_RegWriteData: entity work.mux(rtl)
    generic map(
    N => 32
    )
    port map(
    data_a => R_rs,
    data_b => write_back_data,
    sel => MVZ,
    mux_out => reg_write_data
    );

end rtl;
