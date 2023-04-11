

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EX_mem_reg is
 Port (   --Ulazi
         alu_res:in std_logic_vector(31 downto 0);
         izlaz2_banka:in std_logic_vector(31 downto 0);
         ulaz_banka:in std_logic_vector(4 downto 0);
         clk:in std_logic;
         
         --Izlazi
          izlaz2_banka_o:out std_logic_vector(31 downto 0);
          ulaz_banka_o:out std_logic_vector(4 downto 0);
          address_data:out std_logic_vector(31 downto 0)
 
          );
end EX_mem_reg;

architecture Behavioral of EX_mem_reg is

begin
 EX_MEM:process(clk)is
      begin
        if(rising_edge(clk))then
           izlaz2_banka_o<=izlaz2_banka;
           ulaz_banka_o<=ulaz_banka;
           address_data<=alu_res;
            
        end if;
     end process;

end Behavioral;
