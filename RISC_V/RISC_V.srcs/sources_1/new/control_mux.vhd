----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2023 02:30:01 PM
-- Design Name: 
-- Module Name: control_mux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity control_mux is
 Port (
          in1:in std_logic_vector(3 downto 0);
          in2:in std_logic_vector(3 downto 0);
          sel:in std_logic;
          izlaz:out std_logic_vector(3 downto 0)
 
 
           );
end control_mux;

architecture Behavioral of control_mux is

begin
mux:process(sel)is
    begin
     if(sel='0')then
       izlaz<=in1;
      else
        izlaz<=in2;
     end if;
   end process;
end Behavioral;
