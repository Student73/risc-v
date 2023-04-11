

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;



entity sabirac is
generic(WIDTH:positive:=32);
  Port ( 
          in1:in std_logic_vector(WIDTH-1 downto 0);
          in2:in std_logic_vector(WIDTH-1 downto 0);
          out_add:out std_logic_vector(WIDTH-1 downto 0)
         );
end sabirac;

architecture Behavioral of sabirac is

begin
    out_add<=std_logic_vector(unsigned(in1)+unsigned(in2));

end Behavioral;
