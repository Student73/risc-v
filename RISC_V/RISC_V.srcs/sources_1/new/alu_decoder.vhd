
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_decoder is
 Port (
        --******** Controlpath ulazi *********
           alu_2bit_op_i : in std_logic_vector(1 downto 0);
           
          --******** Polja instrukcije *******
            funct3_i : in std_logic_vector (2 downto 0);
            funct7_i : in std_logic_vector (6 downto 0);
            
          --******** Datapath izlazi ********
            alu_op_o : out std_logic_vector(4 downto 0)
           );
end alu_decoder;

architecture Behavioral of alu_decoder is

begin
ALU:process(alu_2bit_op_i, funct3_i,funct7_i)is
   begin
     if(alu_2bit_op_i="00" and funct7_i="XXXXXXX" and funct3_i="XXX")then
         alu_op_o <="00010";
         
     elsif(alu_2bit_op_i="X1" and funct7_i="XXXXXXX" and funct3_i="XXX")then
           alu_op_o <="00110";
   
     elsif(alu_2bit_op_i="1X" and funct7_i="0000000" and funct3_i="000")then
           alu_op_o <="00010";
   
     elsif(alu_2bit_op_i="1X" and funct7_i="0100000" and funct3_i="000")then
           alu_op_o <="00110";
         
     elsif(alu_2bit_op_i="1X" and funct7_i="0000000" and funct3_i="111")then
           alu_op_o <="00000";
         
     elsif(alu_2bit_op_i="1X" and funct7_i="0000000" and funct3_i="110")then
           alu_op_o <="00001";
     end if;
   end process;

end Behavioral;
