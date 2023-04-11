

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CONTROL_PATH is
 Port (
            -- sinhronizacija
                clk : in std_logic;
                reset : in std_logic;
                
             -- instrukcija dolazi iz datapah-a
                instruction_i : in std_logic_vector (31 downto 0);
                
              -- Statusni signaln iz datapath celine
                branch_condition_i : in std_logic;
                
              -- kontrolni signali koji se prosledjiuju u datapath
                  mem_to_reg_o : out std_logic;
                  alu_op_o : out std_logic_vector(4 downto 0);
                  alu_src_b_o : out std_logic;
                  rd_we_o : out std_logic;
                  pc_next_sel_o : out std_logic;
                  data_mem_we_o : out std_logic_vector(3 downto 0);
                  
                -- kontrolni signali za prosledjivanje operanada u ranije faze protocne
                   alu_forward_a_o : out std_logic_vector (1 downto 0);
                   alu_forward_b_o : out std_logic_vector (1 downto 0);
                   branch_forward_a_o : out std_logic; -- mux a
                   branch_forward_b_o : out std_logic; -- mux b
                  
                  -- kontrolni signal za resetovanje if/id registra
                      if_id_flush_o : out std_logic;
                      
                 -- kontrolni signali za zaustavljanje protocne obrade
                     pc_en_o : out std_logic;
                     if_id_en_o : out std_logic
          );
end CONTROL_PATH;

architecture Behavioral of CONTROL_PATH is
signal mem_to_reg_id_s:std_logic;
signal data_mem_we_id_s:std_logic;
signal alu_src_b_id_s:std_logic;
signal rd_we_id_s:std_logic;
signal rs1_in_use_id_s:std_logic;
signal rs2_in_use_id_s:std_logic;
signal alu_2bit_op_id_s:std_logic_vector(1 downto 0);
signal funct3_id_i:std_logic_vector(2 downto 0);
signal funct7_id_i:std_logic_vector(6 downto 0);
signal rd_address_id_i:std_logic_vector(4 downto 0);
signal rs1_adress_id_i:std_logic_vector(4 downto 0);
signal rs2_adress_id_i:std_logic_vector(4 downto 0);
signal control_pass_s:std_logic;
signal mem_to_reg_ex_o:std_logic;
signal data_mem_we_ex_o:std_logic;
signal rd_we_ex_o:std_logic;
signal alu_2bit_op_ex_o:std_logic_vector(1 downto 0);
signal funct3_ex_o:std_logic_vector(2 downto 0);
signal funct7_ex_o:std_logic_vector(6 downto 0);
signal rd_address_id_o:std_logic_vector(4 downto 0);
signal rs1_adress_id_o:std_logic_vector(4 downto 0);
signal rs2_adress_id_o:std_logic_vector(4 downto 0);
signal mem_to_reg_mem_s:std_logic;
signal rd_we_mem_s:std_logic;
signal sel_muc:std_logic;
signal rd_address_mem_o:std_logic_vector(4 downto 0);
signal rd_adress_mem_izlaz:std_logic_vector(4 downto 0);
signal branch_id_s:std_logic;
signal rd_we_o_banka:std_logic;
signal pc_flush:std_logic;
begin

control_decoder: entity work.CTRL_decoder(Behavioral)
                Port map(   opcode_i=> instruction_i(6 downto 0),
                            branch_o=> branch_id_s,
                            mem_to_reg_o=>mem_to_reg_id_s,
                            data_mem_we_o=>data_mem_we_id_s,
                            alu_src_b_o =>alu_src_b_id_s,
                            rd_we_o =>rd_we_id_s,
                            rs1_in_use_o =>rs1_in_use_id_s,
                            rs2_in_use_o =>rs2_in_use_id_s,
                            alu_2bit_op_o =>alu_2bit_op_id_s
                          );
                          
 kontr_reg1:entity work.kontrol_reg_1(Behavioral) 
            Port map(
                        mem_to_reg_id_s=>mem_to_reg_id_s,
                        data_mem_we_id_s=>data_mem_we_id_s,
                        rd_we_id_s=> rd_we_id_s,
                        alu_src_b_id_s=>alu_src_b_id_s,
                        alu_2bit_op_id_s=> alu_2bit_op_id_s,
                        funct3_id_s=> funct3_id_i,
                        funct7_id_s=>funct7_id_i,
                        clk=>clk,
                        rd_address_id_s=>rd_address_id_i,
                        rs1_adress_id_s=>rs1_adress_id_i,
                        rs2_adress_id_s=>rs2_adress_id_i,
                        control_pass=>control_pass_s,
                        mem_to_reg_ex_s=> mem_to_reg_ex_o,
                        data_mem_we_ex_s=> data_mem_we_ex_o,
                        rd_we_ex_s=>rd_we_ex_o,
                        alu_2bit_op_ex_s=> alu_2bit_op_ex_o,
                        alu_src_b_ex_s=>alu_src_b_o,
                        funct3_ex_s=> funct3_ex_o,
                        funct7_ex_s=>funct7_ex_o,
                        rd_address_id_o=>rd_address_id_o,
                        rs1_adress_id_o=>rs1_adress_id_o,
                        rs2_adress_id_o=>rs2_adress_id_o,
                        reset=>reset
            );
 
kontr_reg2:entity work.kontrol_reg_2(Behavioral)  
           Port map(
                         mem_to_reg_ex_es=>mem_to_reg_ex_o,
                         data_mem_we_ex_s=>data_mem_we_ex_o,
                         rd_we_ex_s=>rd_we_ex_o,
                         clk=>clk,
                         rd_address_i=>rd_address_id_o,
                         mem_to_reg_mem_s=> mem_to_reg_mem_s,
                         rd_we_mem_s=>rd_we_mem_s,
                         sel_muc=> sel_muc,
                         rd_address_mem_o=>rd_address_mem_o,
                         reset=>reset
           
                      );

kontr_reg3:entity work.kontrol_reg_3(Behavioral) 
          Port map(
                    mem_to_reg_mem_s=> mem_to_reg_mem_s,
                    rd_we_mem_s=>rd_we_mem_s,
                    clk=>clk,
                    rd_adress_mem_i=>rd_address_mem_o,
                    rd_we_banka=>rd_we_o_banka,
                    sel_mux=> mem_to_reg_o,
                    rd_adress_mem_o=>rd_adress_mem_izlaz,
                    reset=>reset
                     ); 
 branch:entity work.branch_I_kolo(Behavioral)
        Port map(
                       in1=> branch_condition_i,
                       in2=> branch_id_s,
                       out_and=>pc_flush
                 );
 alu_decoder:entity work.alu_decoder(Behavioral)
             Port map(
                       alu_2bit_op_i=> alu_2bit_op_ex_o,
                       funct3_i =>funct3_ex_o,
                       funct7_i=>funct7_ex_o,
                       alu_op_o =>alu_op_o 
                      );               
forwarding:entity work.forwarding_unit(Behavioral)
           Port map(
                      rs1_address_id_i=>rs1_adress_id_i,
                      rs2_address_id_i=>rs2_adress_id_i,
                      rs1_address_ex_i=>rs1_adress_id_o,
                      rs2_address_ex_i=>rs2_adress_id_o,
                      rd_we_mem_i=>rd_we_mem_s,
                      rd_address_mem_i=>rd_address_mem_o,
                      rd_we_wb_i =>rd_we_o_banka,
                      rd_address_wb_i=>rd_adress_mem_izlaz,
                      alu_forward_a_o=>alu_forward_a_o,
                      alu_forward_b_o =>alu_forward_b_o,
                      branch_forward_a_o=>branch_forward_a_o,
                      branch_forward_b_o=>branch_forward_b_o
                     );
 hazard:entity work.hazard_unit(Behavioral)
        Port map(
                   rs1_address_id_i=>rs1_adress_id_i,
                   rs2_address_id_i=>rs2_adress_id_i,
                   rs1_in_use_i=>rs1_in_use_id_s,
                   rs2_in_use_i=>rs2_in_use_id_s,
                   branch_id_i=> branch_id_s,
                   rd_address_ex_i=>rd_address_id_o,
                   mem_to_reg_ex_i=>mem_to_reg_ex_o,
                   rd_we_ex_i=>rd_we_ex_o,
                   rd_address_mem_i=>rd_address_mem_o,
                   mem_to_reg_mem_i=>mem_to_reg_mem_s,
                   pc_en_o =>pc_en_o,
                   if_id_en_o=>if_id_en_o,
                   control_pass_o=>control_pass_s
                  );
mux:entity work.control_mux(Behavioral)  
   Port map(
             in1=>"0000",
             in2=>"1111",
             sel=>sel_muc,
             izlaz=> data_mem_we_o
            ); 
 rd_we_o<=rd_we_o_banka;
 if_id_flush_o<= pc_flush;
 pc_next_sel_o<= pc_flush;
 funct3_id_i<=instruction_i(14 downto 12);
 funct7_id_i<=instruction_i(31 downto 25);
 rd_address_id_i<=instruction_i(11 downto 7);
 rs1_adress_id_i<=instruction_i(19 downto 15);
 rs2_adress_id_i<=instruction_i(24 downto 20);
                  
end Behavioral;
