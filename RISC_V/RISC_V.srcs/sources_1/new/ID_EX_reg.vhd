


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ID_EX_reg is
Port (    --ulazi
          izlaz1_banka:in std_logic_vector(31 downto 0);
          izlaz2_banka:in std_logic_vector(31 downto 0);
          immediate_izlaz:in std_logic_vector(31 downto 0);
          ulaz_banka:in std_logic_vector(4 downto 0);
          clk:in std_logic;
          
          --izlazi
           a_alu:out std_logic_vector(31 downto 0);
           b1_alu:out std_logic_vector(31 downto 0);
           b2_alu:out std_logic_vector(31 downto 0);
           ulaz_banka_o:out std_logic_vector(4 downto 0);
           izlaz2_banka_o:out std_logic_vector(31 downto 0)
      );
end ID_EX_reg;

architecture Behavioral of ID_EX_reg is

begin
 id_ex_reg:process(clk)is
          begin
          if(rising_edge(clk))then
             a_alu <=izlaz1_banka;
             b1_alu <=izlaz2_banka;
             izlaz2_banka_o<=izlaz2_banka;
             ulaz_banka_o<=ulaz_banka;
             b2_alu <=immediate_izlaz;
           end if;
          end process;


end Behavioral;
