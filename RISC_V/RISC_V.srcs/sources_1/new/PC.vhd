


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity PC is
generic(WIDTH:positive:=32);
Port (
           clk:in std_logic;
           d:in std_logic_vector(WIDTH-1 downto 0);
           en:in std_logic;
           q:out std_logic_vector(WIDTH-1 downto 0)
           
         );
end PC;

architecture Behavioral of PC is
begin
  cnt:process(clk)is
      begin
        if(rising_edge(clk))then
           if(en='1')then
              q<=d;
           end if;
        end if;
        
    end process;
end Behavioral;
