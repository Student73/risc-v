


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MEM_WB_reg is
 Port (    --Ulazi
            data_mem:in std_logic_vector(31 downto 0);
            alu_res:in std_logic_vector(31 downto 0);
            ulaz_banka:in std_logic_vector(4 downto 0);
            clk:in std_logic;
          --Izlazi
            mux_1:out std_logic_vector(31 downto 0);
            mux_2:out std_logic_vector(31 downto 0);
            ulaz_banka_o:out std_logic_vector(4 downto 0)
  );
end MEM_WB_reg;

architecture Behavioral of MEM_WB_reg is

begin
 MEM_WB:process(clk)is
       begin
         if(rising_edge(clk))then
           mux_1<= alu_res;
           mux_2<=data_mem;
           ulaz_banka_o<= ulaz_banka;
         end if;
     
       end process;

end Behavioral;
