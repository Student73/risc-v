----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2023 12:11:54 PM
-- Design Name: 
-- Module Name: hazard_unit - Behavioral
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


entity hazard_unit is
Port (
       -- ulazni signali
          rs1_address_id_i : in std_logic_vector(4 downto 0);
          rs2_address_id_i : in std_logic_vector(4 downto 0);
          rs1_in_use_i : in std_logic;
          rs2_in_use_i : in std_logic;
          branch_id_i : in std_logic;

         rd_address_ex_i : in std_logic_vector(4 downto 0);
         mem_to_reg_ex_i : in std_logic;
         rd_we_ex_i : in std_logic;
         rd_address_mem_i : in std_logic_vector(4 downto 0);
         mem_to_reg_mem_i : in std_logic;
         
      -- izlazni kontrolni signali
         pc_en_o : out std_logic;
         if_id_en_o : out std_logic;
         control_pass_o : out std_logic
     );
end hazard_unit;

architecture Behavioral of hazard_unit is
signal en_s:std_logic:='0';
signal pass_ctrl_s:std_logic:='0';
begin

hazard:process (rs1_address_id_i, rs2_address_id_i, branch_id_i, rd_address_ex_i,rd_we_ex_i,
rd_address_mem_i, mem_to_reg_ex_i, mem_to_reg_mem_i, rs1_in_use_i,rs2_in_use_i) is
       begin
        en_s <= '1';
         if (branch_id_i = '0') then 
            if(((rs1_address_id_i = rd_address_ex_i and rs1_in_use_i = '1') or(rs2_address_id_i = rd_address_ex_i and rs2_in_use_i = '1')) and mem_to_reg_ex_i = '1' and rd_we_ex_i = '1')then 
                 en_s <='0';
            end if;
         elsif(branch_id_i = '1')then
               if((rs1_address_id_i = rd_address_ex_i or rs2_address_id_i =rd_address_ex_i)and rd_we_ex_i = '1')then
                  en_s <='0';
               elsif((rs1_address_id_i = rd_address_mem_i or rs2_address_id_i =rd_address_mem_i)and mem_to_reg_mem_i = '1')then
                    en_s <='0';
               end if;
         end if;
  end process;
  
pc_en_o <= en_s;
if_id_en_o <= en_s;
control_pass_o <= en_s;

end Behavioral;
