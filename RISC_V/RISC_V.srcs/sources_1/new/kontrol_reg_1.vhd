----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2023 06:47:02 PM
-- Design Name: 
-- Module Name: kontrol_reg_1 - Behavioral
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


entity kontrol_reg_1 is
 Port ( 
         --Ulazi
          mem_to_reg_id_s:in std_logic;
          data_mem_we_id_s:in std_logic;
          rd_we_id_s: in std_logic;
          alu_src_b_id_s:in std_logic;
          alu_2bit_op_id_s:in std_logic_vector(1 downto 0);
          funct3_id_s:in std_logic_vector(2 downto 0);
          funct7_id_s:in std_logic_vector(6 downto 0);
          clk:in std_logic;
          rd_address_id_s:in std_logic_vector(4 downto 0);
          rs1_adress_id_s:in std_logic_vector(4 downto 0);
          rs2_adress_id_s:in std_logic_vector(4 downto 0);
          control_pass:in std_logic;
          reset:in std_logic;
        --Izlazi
          mem_to_reg_ex_s:out std_logic;
          data_mem_we_ex_s:out std_logic;
          rd_we_ex_s:out std_logic;
          alu_2bit_op_ex_s:out std_logic_vector(1 downto 0);
          alu_src_b_ex_s:out std_logic;
          funct3_ex_s:out std_logic_vector(2 downto 0);
          funct7_ex_s:out std_logic_vector(6 downto 0);
          rd_address_id_o:out std_logic_vector(4 downto 0);
          rs1_adress_id_o:out std_logic_vector(4 downto 0);
          rs2_adress_id_o:out std_logic_vector(4 downto 0)
         );
end kontrol_reg_1;

architecture Behavioral of kontrol_reg_1 is

begin
reg1:process(clk)is
     begin
       if(rising_edge(clk))then
          if(control_pass='1')then
            if(reset='1')then
             mem_to_reg_ex_s<='0';
             data_mem_we_ex_s<='0';
             rd_we_ex_s<='0';
             alu_2bit_op_ex_s<="00";
             alu_src_b_ex_s<='0';
             funct3_ex_s<= "000";
             funct7_ex_s<="0000000";
             rd_address_id_o<=(others=>'0');
             rs1_adress_id_o<=(others=>'0');
             rs2_adress_id_o<=(others=>'0');
            else
             mem_to_reg_ex_s<= mem_to_reg_id_s;
             data_mem_we_ex_s<= data_mem_we_id_s;
             rd_we_ex_s<= rd_we_id_s;
             alu_2bit_op_ex_s<=alu_2bit_op_id_s;
             alu_src_b_ex_s<=alu_src_b_id_s;
             funct3_ex_s<= funct3_id_s;
             funct7_ex_s<=funct7_id_s;
             rd_address_id_o<= rd_address_id_s;
             rs1_adress_id_o<=rs1_adress_id_s;
             rs2_adress_id_o<=rs2_adress_id_s;
            end if;
          end if;
        end if;  
     end process;

end Behavioral;
