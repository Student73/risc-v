


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity pomerac is
 Port (
         in1:in std_logic_vector(31 downto 0);
         out1:out std_logic_vector(31 downto 0)
        );
end pomerac;

architecture Behavioral of pomerac is

begin
   out1<=in1(30 downto 0)&'0';
end Behavioral;
