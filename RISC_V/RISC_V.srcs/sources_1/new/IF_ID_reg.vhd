

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity IF_ID_reg is
 Port ( 
         instruction_mem:in std_logic_vector(31 downto 0);
         in1_add:in std_logic_vector(31 downto 0);
         out_add:in std_logic_vector(31 downto 0);
         
         if_id_en:in std_logic; --signal dozvole
         if_id_flush:in std_logic; --resetuje  
         
         in1_mux:out std_logic_vector(31 downto 0);
         in1_adde:out std_logic_vector(31 downto 0);
         rs1_reg:out std_logic_vector(31 downto 0);
         
         clk:in std_logic
 
 );
end IF_ID_reg;

architecture Behavioral of IF_ID_reg is

begin
 reg:process(clk)is
     begin
      if(rising_edge(clk))then
        if(if_id_en='1')then
           if(if_id_flush='1')then
                in1_mux<=(others=>'0');
                in1_adde<=(others=>'0');
                rs1_reg<=(others=>'0');
            else
                 in1_mux<= out_add;
                 in1_adde<= in1_add;
                 rs1_reg<=instruction_mem;
           end if;
         end if;
        end if;
 end process;
end Behavioral;
