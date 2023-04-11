


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity kontrol_reg_3 is
Port (     --Ulazi
             mem_to_reg_mem_s:in std_logic;
             rd_we_mem_s:in std_logic;
             clk:in std_logic;
             rd_adress_mem_i:in std_logic_vector(4 downto 0);
             reset:in std_logic;
           --Izlazi
            rd_we_banka:out std_logic;
            sel_mux:out std_logic;
            rd_adress_mem_o:out std_logic_vector(4 downto 0)
        );
end kontrol_reg_3;

architecture Behavioral of kontrol_reg_3 is

begin
reg:process(clk)is
   begin
    if(rising_edge(clk))then
       if(reset='1')then
         rd_we_banka<='0';
         sel_mux<= '0';
         rd_adress_mem_o<=(others=>'0');
       else
        rd_we_banka<= rd_we_mem_s;
        sel_mux<= mem_to_reg_mem_s;
        rd_adress_mem_o<=rd_adress_mem_i;
       end if;
    end if;
  end process;

end Behavioral;
