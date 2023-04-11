


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CTRL_decoder is
 Port ( 
        -- opcode instrukcije
            opcode_i : in std_logic_vector (6 downto 0);
            
         -- kontrolni signali
            branch_o : out std_logic;
            mem_to_reg_o : out std_logic;
            data_mem_we_o : out std_logic;
            alu_src_b_o : out std_logic;
            rd_we_o : out std_logic;
            rs1_in_use_o : out std_logic;
            rs2_in_use_o : out std_logic;
            alu_2bit_op_o : out std_logic_vector(1 downto 0)
         );
end CTRL_decoder;

architecture Behavioral of CTRL_decoder is

begin
CTRL:process(opcode_i)is
     begin
      if(opcode_i="0110011")then
          branch_o <='0';
          mem_to_reg_o<='0';
          data_mem_we_o<='0';
          alu_src_b_o<='0';
          rd_we_o<='1';
          rs1_in_use_o <='1';
          rs2_in_use_o <='1';
          alu_2bit_op_o(0)<='0';
          alu_2bit_op_o(1)<='1';
          
     elsif(opcode_i="0000011")then
          branch_o <='0';
          mem_to_reg_o<='1';
          data_mem_we_o<='0';
          alu_src_b_o<='1';
          rd_we_o<='1';
          rs1_in_use_o <='1';
          rs2_in_use_o <='0';
          alu_2bit_op_o(0)<='0';
          alu_2bit_op_o(1)<='0';
     
      elsif(opcode_i="0100011")then
          branch_o <='0';
          mem_to_reg_o<='X';
          data_mem_we_o<='1';
          alu_src_b_o<='1';
          rd_we_o<='0';
          rs1_in_use_o <='1';
          rs2_in_use_o <='1';
          alu_2bit_op_o(0)<='0';
          alu_2bit_op_o(1)<='0';
     
      elsif(opcode_i="1100011")then
          branch_o <='1';
          mem_to_reg_o<='0';
          data_mem_we_o<='0';
          alu_src_b_o<='X';
          rd_we_o<='0';
          rs1_in_use_o <='1';
          rs2_in_use_o <='1';
          alu_2bit_op_o(0)<='1';
          alu_2bit_op_o(1)<='0';
          
        elsif(opcode_i="0010011")then
          branch_o <='0';
          mem_to_reg_o<='0';
          data_mem_we_o<='0';
          alu_src_b_o<='1';
          rd_we_o<='1';
          rs1_in_use_o <='1';
          rs2_in_use_o <='0';
          alu_2bit_op_o(0)<='1';
          alu_2bit_op_o(1)<='1'; 
         
         else
          branch_o <='0';
          mem_to_reg_o<='0';
          data_mem_we_o<='0';
          alu_src_b_o<='0';
          rd_we_o<='0';
          rs1_in_use_o <='0';
          rs2_in_use_o <='0';
          alu_2bit_op_o(0)<='0';
          alu_2bit_op_o(1)<='0'; 
          
       end if;
     
     end process;

end Behavioral;
