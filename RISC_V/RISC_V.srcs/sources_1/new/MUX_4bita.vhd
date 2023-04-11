


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity MUX_4bita is
 Port ( 
            in1:in std_logic_vector(31 downto 0);
            in2:in std_logic_vector(31 downto 0);
            in3:in std_logic_vector(31 downto 0);
            in4:in bit:='1';
            izlaz:out std_logic_vector(31 downto 0);
            sel:in std_logic_vector(1 downto 0)
         );
end MUX_4bita;

architecture Behavioral of MUX_4bita is

begin
mux_4:process(in1,in2,in3,in4,sel)is
     begin
     if(sel="00")then
        izlaz<=in1;
        
     elsif(sel="01")then
        izlaz<=in2;
        
     elsif(sel="10")then
        izlaz<=in3;
     
     end if;
   end process;

end Behavioral;
