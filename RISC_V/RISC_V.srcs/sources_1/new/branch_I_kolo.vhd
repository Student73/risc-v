----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2023 06:40:14 PM
-- Design Name: 
-- Module Name: branch_I_kolo - Behavioral
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


entity branch_I_kolo is
 Port (
         in1:in std_logic;
         in2:in std_logic;
         out_and:out std_logic
          );
end branch_I_kolo;

architecture Behavioral of branch_I_kolo is

begin
  out_and<=in1 and in2;

end Behavioral;
