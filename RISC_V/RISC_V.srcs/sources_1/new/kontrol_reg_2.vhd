


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity kontrol_reg_2 is
 Port (   --Ulazi
          mem_to_reg_ex_es:in std_logic;
          data_mem_we_ex_s:in std_logic;
          rd_we_ex_s:in std_logic;
          clk:in std_logic;
          rd_address_i:in std_logic_vector(4 downto 0);
          reset:in std_logic;
         --Izlazi
          mem_to_reg_mem_s:out std_logic;
          rd_we_mem_s:out std_logic;
          sel_muc:out std_logic;
          rd_address_mem_o:out std_logic_vector(4 downto 0)
 
           );
end kontrol_reg_2;

architecture Behavioral of kontrol_reg_2 is

begin
 reg:process(clk)is
     begin
      if(rising_edge(clk))then
        if(reset='1')then
           mem_to_reg_mem_s<='0';
           rd_we_mem_s<='0';
           sel_muc<= '0';
           rd_address_mem_o<= (others=>'0');     
        else
         mem_to_reg_mem_s<=  mem_to_reg_ex_es;
         rd_we_mem_s<=rd_we_ex_s;
         sel_muc<= data_mem_we_ex_s;
         rd_address_mem_o<= rd_address_i;
        end if;
     end if;
   end process;

end Behavioral;
