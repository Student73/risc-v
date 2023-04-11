
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity EXECUTE_phase is
Port (     --Ulazi
           b2_alu:in std_logic_vector(31 downto 0);
           alu_src:in std_logic;
           alu_dec:in std_logic_vector(4 downto 0);
           alu_forward_a:in std_logic_vector(1 downto 0);
           alu_forward_b:in std_logic_vector(1 downto 0);
           izlaz1_banka:in std_logic_vector(31 downto 0);
           izlaz2_banka:in std_logic_vector(31 downto 0);
           rd_data_i : in std_logic_vector(31 downto 0);
           address_data:in std_logic_vector(31 downto 0);
           --Izlazi
           alu_out:out std_logic_vector(31 downto 0)

       );
end EXECUTE_phase;

architecture Behavioral of EXECUTE_phase is
signal b1_alu_ulaz,a_alu,b_alu_ulaz:std_logic_vector(31 downto 0);
begin

ALU: entity work.ALU(Behavioral)
     Port map(
                a_i => a_alu,
                b_i =>b_alu_ulaz,
                op_i =>alu_dec,
                res_o =>alu_out
                 ); 
     
  MUX: entity work.MUX(Behavioral)
     Port map(
                in1=> b1_alu_ulaz,
                in2=> b2_alu,
                sel=>alu_src,
                out_mux=>b_alu_ulaz
                 ); 
   MUX1: entity work.MUX_4bita(Behavioral)
     Port map(
                in1=> izlaz1_banka,
                in2=> rd_data_i,
                in3=> address_data,
                in4=>open,
                sel=>alu_forward_a,
                izlaz=>a_alu);
                
    MUX2: entity work.MUX_4bita(Behavioral)
     Port map(
                in1=> izlaz2_banka,
                in2=> rd_data_i,
                in3=> address_data,
                in4=>open,
                sel=>alu_forward_b,
                izlaz=>b1_alu_ulaz
                 );                       
                           
           
end Behavioral;
