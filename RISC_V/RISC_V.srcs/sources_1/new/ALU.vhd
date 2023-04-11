
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ALU is
GENERIC(WIDTH : NATURAL := 32);
PORT(
      a_i : in STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0); --prvi operand
      b_i : in STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0); --drugi operand
      op_i : in STD_LOGIC_VECTOR(4 DOWNTO 0); --port za izbor operacije
      res_o : out STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0)
      );
     
end ALU;

architecture Behavioral of ALU is
begin
  operacije:process(op_i,a_i,b_i) is
            begin
             if(op_i="00000")then
                   res_o<=a_i and b_i;
                elsif(op_i="00001")then
                   res_o<=a_i or b_i;
                elsif(op_i="00010")then
                   res_o<=std_logic_vector(unsigned(a_i)+ unsigned(b_i));
                elsif(op_i="00110")then
                  res_o<=std_logic_vector(unsigned(a_i)- unsigned(b_i));
              end if;
              
           end process;
  

end Behavioral;
