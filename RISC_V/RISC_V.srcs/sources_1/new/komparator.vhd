


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity komparator is
 Port (
          in1:in std_logic_vector(31 downto 0);
          in2:in std_logic_vector(31 downto 0);
          out_komparator:out std_logic
          );
end komparator;

architecture Behavioral of komparator is

begin
 komparator:process(in1,in2)is
           begin
             if(in1=in2)then
               out_komparator<='1';
             else
               out_komparator<='0';
             end if;
           
           end process;

end Behavioral;
