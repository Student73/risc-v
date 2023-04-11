

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity DATA_MEM is
  Port (
               --Ulazi
               clk:in std_logic;
               address:in std_logic_vector(31 downto 0);
               data_i:in std_logic_vector(31 downto 0);
               data_we:in std_logic_vector(3 downto 0);
               
               --izlaz
                data_o:out std_logic_vector(31 downto 0)
  
           );
end DATA_MEM;

architecture Behavioral of DATA_MEM is

type ram_type_t is array (0 to 31) of std_logic_vector(31 downto 0);
signal ram_s: ram_type_t;

begin

DATA:process(clk)is
    begin
      if(rising_edge(clk))then
        if(data_we="1111")then
           ram_s(to_integer(unsigned(address)))<= data_i;
         end if;
       end if;
 end process;
 
 data_o <= ram_s(to_integer(unsigned(address)));
 
end Behavioral;
