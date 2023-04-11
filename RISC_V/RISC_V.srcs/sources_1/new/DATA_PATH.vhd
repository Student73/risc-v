


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity DATA_PATH is
Port ( 
          -- sinhronizacioni signali
               clk : in std_logic;
               reset : in std_logic;
               
         -- interfejs ka memoriji za instrukcije
             instr_mem_address_o : out std_logic_vector (31 downto 0);
             instr_mem_read_i : in std_logic_vector(31 downto 0);
             instruction_o : out std_logic_vector(31 downto 0);
             
           -- interfejs ka memoriji za podatke
             data_mem_address_o : out std_logic_vector(31 downto 0);
             data_mem_write_o : out std_logic_vector(31 downto 0);
             data_mem_read_i : in std_logic_vector (31 downto 0);
             
              -- kontrolni signali
             mem_to_reg_i : in std_logic;             
             alu_op_i : in std_logic_vector (4 downto 0);
             alu_src_b_i : in std_logic;
             pc_next_sel_i : in std_logic;
             rd_we_i : in std_logic;
             branch_condition_o : out std_logic;
             we_data:in std_logic_vector(3 downto 0);
           -- kontrolni signali za prosledjivanje operanada u ranije faze protocne
                 alu_forward_a_i : in std_logic_vector (1 downto 0);
                 alu_forward_b_i : in std_logic_vector (1 downto 0);
                 branch_forward_a_i : in std_logic;
                 branch_forward_b_i : in std_logic;
                 
           -- kontrolni signal za resetovanje if/id registra
               if_id_flush_i : in std_logic;
               
            -- kontrolni signali za zaustavljanje protocne obrade
                  pc_en_i : in std_logic;
                  if_id_en_i : in std_logic




      
       );
end DATA_PATH;

architecture Behavioral of DATA_PATH is

signal add_out:std_logic_vector(31 downto 0); --izlaz sabiraca u 2.fazi
signal rs1_reg:std_logic_vector(31 downto 0);--ulaz 1. reg banke
signal in1_adde:std_logic_vector(31 downto 0);--izlaz iz reg,ulaz u sabirac 2.faze
signal PC_out:std_logic_vector(31 downto 0);--izlaz iz PC ulaz u instruction
signal out_instruction_mem:std_logic_vector(31 downto 0);--izlaz iz instr mem
signal in1_mux:std_logic_vector(31 downto 0);--1. ulaz u mux 1.faze
signal imediate_out:std_logic_vector(31 downto 0);--izlaz immediate jedinice
signal rs1_data:std_logic_vector(31 downto 0);--1. Izlaz iz banke
signal rs2_data:std_logic_vector(31 downto 0);--2. Izlaz iz banke
signal rd_data:std_logic_vector(31 downto 0);--upis podataka 
signal upis_adrese:std_logic_vector(4 downto 0);--upis adrese
signal a_alu:std_logic_vector(31 downto 0);--00mux ulaz u alu
signal b1_alu:std_logic_vector(31 downto 0);--00 ulaz u mux u alu
signal b2_alu:std_logic_vector(31 downto 0);--1ulaz u mux u alu
signal izlaz2_banka:std_logic_vector(31 downto 0);--rs2_data posle idex reg
signal ulaz_banka:std_logic_vector(4 downto 0);--4 bita koja ce se upisati na rd_address posle idex
signal alu_out:std_logic_vector(31 downto 0);--Izlaz iz alu
signal address_data_mem:std_logic_vector(31 downto 0);--adresni ulaz data memorije 
signal data_i_data_mem:std_logic_vector(31 downto 0);--ulaz data_i kod data meme
signal ulaz_banka_o:std_logic_vector(4 downto 0);--rs1_reg(11 downto 7)posle ex mem faze
signal izlaz_data_mem:std_logic_vector(31 downto 0);--Izlaz data memorije
signal izlaz_mem_wb1:std_logic_vector(31 downto 0);--izlaz iz mem wb reg-ulaz u 0 mux
signal izlaz_mem_wb2:std_logic_vector(31 downto 0);--izlaz iz mem wb reg-ulaz u 1 mux
begin

instruction_fetch_phase: entity work.instruction_fetch_phase(Behavioral)
                        Port map(
                                    pc_en=> pc_en_i,
                                    pc_next_sel=>pc_next_sel_i,
                                    in_mux=>in1_mux,
                                    out1=>out_instruction_mem,
                                    out2=>PC_out,
                                    clks=>clk
                                  );
 IF_ID_reg:entity work.IF_ID_reg(Behavioral)
                        Port map(
                                     instruction_mem=>out_instruction_mem,
                                     in1_add=>PC_out,
                                     out_add=>add_out,
                                     if_id_en=>if_id_en_i,
                                     if_id_flush=>if_id_flush_i, 
                                     in1_mux=>in1_mux,
                                     in1_adde=>in1_adde,
                                     rs1_reg=>rs1_reg,
                                     clk=>clk
                                  );    
  instruction_decode_phase: entity work.Instruction_decode_phase(Behavioral)
                        Port map(
                                     out_if_reg=>rs1_reg,
                                     add_in=>in1_adde,
                                     ulaz_za_upis1=>upis_adrese,
                                     ulaz_za_upis2=>rd_data,
                                     branch_forward_a=> branch_forward_a_i,
                                     branch_forward_b=> branch_forward_b_i,
                                     add_out=>add_out,
                                     komparator_out=>branch_condition_o,
                                     out1_banka=>rs1_data,
                                     out2_banka=>rs2_data,
                                     imediate_out=>imediate_out,
                                     clk=>clk,
                                     upis=> rd_we_i,
                                     reset=>reset
                                  );    
  ID_EX_reg:entity work.ID_EX_reg(Behavioral)
                        Port map(
                                    izlaz1_banka=>rs1_data,
                                    izlaz2_banka=>rs2_data,
                                    immediate_izlaz=>imediate_out,
                                    ulaz_banka=>rs1_reg(11 downto 7),
                                    clk=>clk,
                                    a_alu=>a_alu,
                                    b1_alu=>b1_alu,
                                    b2_alu=>b2_alu,
                                    ulaz_banka_o=>ulaz_banka,
                                    izlaz2_banka_o=> izlaz2_banka
                                  );  
  EXECUTE_phase: entity work.EXECUTE_phase(Behavioral)
                        Port map(
                                     b2_alu=>b2_alu,
                                     alu_src=>alu_src_b_i,
                                     alu_dec=>alu_op_i,
                                     alu_forward_a=>alu_forward_a_i,
                                     alu_forward_b=>alu_forward_b_i,
                                     izlaz1_banka=>a_alu,
                                     izlaz2_banka=>b1_alu,
                                     rd_data_i=>rd_data,
                                     address_data=>address_data_mem,
                                     alu_out=>alu_out
                                  );  
 EX_MEM_reg:entity work.EX_mem_reg(Behavioral)
                        Port map(
                                   alu_res=>alu_out,
                                   izlaz2_banka=>izlaz2_banka,
                                   ulaz_banka=>ulaz_banka,
                                   clk=>clk,
                                   izlaz2_banka_o=>data_i_data_mem,
                                   ulaz_banka_o=>ulaz_banka_o,
                                   address_data=>address_data_mem
                                  );                                                                                                                                   
 DATA_mem:  entity work.DATA_MEM(Behavioral)
                        Port map(
                                    address=>address_data_mem,
                                    data_i=>data_i_data_mem,
                                    data_we=>we_data,
                                    data_o=>izlaz_data_mem,
                                    clk=>clk
                                  ); 
 MEM_WB_reg:entity work.MEM_WB_reg(Behavioral)
                        Port map(
                                   data_mem=>izlaz_data_mem,
                                   alu_res=>address_data_mem,
                                   ulaz_banka=>ulaz_banka_o,
                                   clk=>clk,
                                  
                                   mux_1=>izlaz_mem_wb1,
                                   mux_2=>izlaz_mem_wb2,
                                   ulaz_banka_o=>upis_adrese
                                  );
  MUX: entity work.MUX(Behavioral)
                        Port map(
                                    in1=>izlaz_mem_wb1,
                                    in2=>izlaz_mem_wb2,
                                    sel=>mem_to_reg_i ,
                                    out_mux=>rd_data
                                  );
                                   
    data_mem_address_o<=address_data_mem;
    data_mem_write_o<=izlaz_data_mem;
    data_i_data_mem<=data_mem_read_i;
    
    instr_mem_address_o<=out_instruction_mem;
    PC_out<=instr_mem_read_i;
    instruction_o<=rs1_reg;                                                                                                                                                                   

end Behavioral;
