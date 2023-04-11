

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity immediate is
 Port ( instruction_i : in std_logic_vector (31 downto 0);
        immediate_extended_o : out std_logic_vector (31 downto 0)
       );
end immediate;

architecture Behavioral of immediate is
  constant zero:std_logic_vector(19 downto 0):="00000000000000000000";
  constant ones:std_logic_vector(19 downto 0):="11111111111111111111";
begin
 process(instruction_i)is
   begin
      if(instruction_i(31)='0')then
         immediate_extended_o<=zero&instruction_i(31 downto 20);
  
      elsif(instruction_i(31)='1')then
           immediate_extended_o<=ones&instruction_i(31 downto 20);
      end if;
   end process;
end Behavioral;
