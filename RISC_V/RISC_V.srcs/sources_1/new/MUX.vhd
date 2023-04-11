


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity MUX is
generic(WIDTH:positive:=32);
 Port (
          in1:in std_logic_vector(WIDTH-1 downto 0);
          in2:in std_logic_vector(WIDTH-1 downto 0);
          sel:in std_logic;
          out_mux:out std_logic_vector(WIDTH-1 downto 0)
 
        );
end MUX;

architecture Behavioral of MUX is

begin
  mux:process(sel,in1,in2)is
      begin
      if(sel='0')then
         out_mux<=in1;
        else
          out_mux<=in2;
       end if;
       
      end process;

end Behavioral;
