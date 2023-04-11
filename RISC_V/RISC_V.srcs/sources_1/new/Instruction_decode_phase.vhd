


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Instruction_decode_phase is
 Port ( 
         --ulazi
         out_if_reg:in std_logic_vector(31 downto 0 );
         add_in:in std_logic_vector(31 downto 0);
         ulaz_za_upis1:in std_logic_vector(4 downto 0);
         ulaz_za_upis2:in std_logic_vector(31 downto 0);
         branch_forward_a:in std_logic;
         branch_forward_b:in std_logic;
         --Izlazi
         add_out:out std_logic_vector(31 downto 0);
         komparator_out:out std_logic;
         out1_banka:out std_logic_vector(31 downto 0);
         out2_banka:out std_logic_vector(31 downto 0);
         imediate_out:out std_logic_vector(31 downto 0);
         
         clk:in std_logic;
         upis:in std_logic;
         reset:in std_logic
            );
end Instruction_decode_phase;

architecture Behavioral of Instruction_decode_phase is
signal addin,immediate_s,reg_s1,reg_s2,out_mux1,out_mux2:std_logic_vector(31 downto 0);
begin

registarska_banka: entity work.reg_banka(Behavioral)
                   Port map(
                             clk =>clk,
                             reset=>reset,
                             
                             rs1_address_i=>out_if_reg(19 downto 15),
                             rs1_data_o =>reg_s1,
                             
                             rs2_address_i=>out_if_reg(24 downto 20),
                             rs2_data_o=>reg_s2,
                             
                             rd_we_i=>upis,
                             rd_address_i=>ulaz_za_upis1,
                             rd_data_i=>ulaz_za_upis2
                            );
                            
immediate:entity work.immediate(Behavioral)
                   Port map(
                             instruction_i=>out_if_reg,
                             immediate_extended_o => immediate_s
                            );
                            
 pomerac: entity work.pomerac(Behavioral)
                   Port map(
                            in1=>immediate_s,
                            out1=>addin
                            );       
 sabirac: entity work.sabirac(Behavioral)
                   Port map(
                            in1=>addin,
                            in2=>add_in,
                            out_add=> add_out
                            );        
 komparator: entity work.komparator(Behavioral)
                   Port map(
                            in1=>out_mux1,
                            in2=>out_mux2,
                            out_komparator=>komparator_out
                            );  
  MUX1:entity work.MUX(Behavioral)
                   Port map(
                            in1=>reg_s1,
                            in2=>ulaz_za_upis2,
                            sel=> branch_forward_a,
                            out_mux=>out_mux1
                            ); 
                           
  MUX2:entity work.MUX(Behavioral)
                   Port map(
                            in1=>reg_s2,
                            in2=>ulaz_za_upis2,
                            sel=> branch_forward_b,
                            out_mux=>out_mux2
                            );                                                                                                      

imediate_out<=immediate_s;
out1_banka<=reg_s1;
out2_banka<=reg_s2;

end Behavioral;
