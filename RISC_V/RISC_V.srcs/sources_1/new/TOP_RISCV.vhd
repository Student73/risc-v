


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TOP_RISCV is
Port (
            -- Globalna sinhronizacija
               clk : in std_logic;
               reset : in std_logic;
               
           -- Interfejs ka memoriji za podatke
              instr_mem_address_o : out std_logic_vector(31 downto 0);
              instr_mem_read_i : in std_logic_vector(31 downto 0);
              
           -- Interfejs ka memoriji za instrukcije
              data_mem_address_o : out std_logic_vector(31 downto 0);
              data_mem_read_i : in std_logic_vector(31 downto 0);
              data_mem_write_o : out std_logic_vector(31 downto 0);
              data_mem_we_o : out std_logic_vector(3 downto 0)
       );
end TOP_RISCV;

architecture Behavioral of TOP_RISCV is
signal registarska_banka_control:std_logic_vector(31 downto 0);
signal dozvola_upisa_data_mem:std_logic_vector(3 downto 0);
signal branch:std_logic;
signal alu_forward_a:std_logic_vector (1 downto 0);
signal alu_forward_b:std_logic_vector (1 downto 0);
signal branch_forward_a:std_logic;
signal branch_forward_b:std_logic;
signal  if_id_flush:std_logic;
signal  pc_en:std_logic;
signal  if_id_en :std_logic;
signal  alu_op:std_logic_vector(4 downto 0);
signal mem_to_reg:std_logic;
signal  alu_src_b:std_logic;
signal  pc_next_sel: std_logic;
signal  rd_we :std_logic;
begin

DATA:entity work.DATA_PATH(Behavioral)
     Port map(
             clk =>clk,
             reset=>reset,
             instr_mem_address_o=>instr_mem_address_o,
             instr_mem_read_i =>instr_mem_read_i,
             instruction_o=>registarska_banka_control,
             data_mem_address_o =>data_mem_address_o,
             data_mem_write_o=>data_mem_write_o,
             data_mem_read_i=>data_mem_read_i,
             mem_to_reg_i =>mem_to_reg,            
             alu_op_i=> alu_op,
             alu_src_b_i=>alu_src_b,
             pc_next_sel_i=>pc_next_sel,
             rd_we_i => rd_we,
             branch_condition_o=>branch,
             we_data=>dozvola_upisa_data_mem,
             alu_forward_a_i=>alu_forward_a,
             alu_forward_b_i =>alu_forward_b,
             branch_forward_a_i=>branch_forward_a,
             branch_forward_b_i=>branch_forward_b,
             if_id_flush_i=>if_id_flush,
             pc_en_i=> pc_en,
             if_id_en_i=>if_id_en
           );

Control:entity work.CONTROL_PATH(Behavioral)
        Port map(
                  
                clk=>clk,
                reset=>reset,
                instruction_i =>registarska_banka_control,
                branch_condition_i=>branch,
                mem_to_reg_o =>mem_to_reg,
                alu_op_o=> alu_op,
                alu_src_b_o =>alu_src_b,
                rd_we_o=> rd_we,
                pc_next_sel_o=>pc_next_sel,
                data_mem_we_o=>dozvola_upisa_data_mem,
                alu_forward_a_o=>alu_forward_a,
                alu_forward_b_o=>alu_forward_b,
                branch_forward_a_o =>branch_forward_a,
                branch_forward_b_o=>branch_forward_b,
                if_id_flush_o=>if_id_flush,
                pc_en_o =>pc_en,
                if_id_en_o=>if_id_en
                );
data_mem_we_o<=dozvola_upisa_data_mem;



end Behavioral;
