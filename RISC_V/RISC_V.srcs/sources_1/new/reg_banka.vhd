


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity reg_banka is
 generic (WIDTH : positive := 32);
 port (clk : in std_logic;
       reset : in std_logic;
     -- Interfejs 1 za citanje podataka
      rs1_address_i : in std_logic_vector(4 downto 0);
      rs1_data_o : out std_logic_vector(WIDTH - 1 downto 0);
      
     -- Interfejs 2 za citanje podataka
      rs2_address_i : in std_logic_vector(4 downto 0);
      rs2_data_o : out std_logic_vector(WIDTH - 1 downto 0);
      
     -- Interfejs za upis podataka
     rd_we_i : in std_logic; -- port za dozvolu upisa
     rd_address_i : in std_logic_vector(4 downto 0);
     rd_data_i : in std_logic_vector(WIDTH - 1 downto 0));
end reg_banka;

architecture Behavioral of reg_banka is
 type reg_file_t is array(0 to 31)of std_logic_vector(31 downto 0);
 signal reg_file_s:reg_file_t:=(others=>(others=>'0'));
begin
    upis:process(clk, rs1_address_i, reset, rs2_address_i,rd_we_i,rd_address_i, rd_data_i)is
       begin
        if(falling_edge(clk))then
            if(reset='0')then
               reg_file_s<=(others => (others => '0'));
               rs1_data_o <= (others => '0');
               rs2_data_o <=  (others => '0');
           else
            if(rd_we_i='1')then
               reg_file_s(to_integer(unsigned(rd_address_i)))<=rd_data_i;
            end if;
         end if;
       end if;
       end process;
    rs1_data_o<=reg_file_s(to_integer(unsigned(rs1_address_i )));
    rs2_data_o<=reg_file_s(to_integer(unsigned(rs2_address_i )));
       

end Behavioral;
