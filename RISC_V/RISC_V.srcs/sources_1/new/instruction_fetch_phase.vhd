


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity instruction_fetch_phase is
 Port ( 
        pc_en:in std_logic;
        pc_next_sel:in std_logic;
        in_mux:in std_logic_vector(31 downto 0);
        
        out1:out std_logic_vector(31 downto 0);
        out2:out std_logic_vector(31 downto 0);
        
        clks:in std_logic
 
        );
end instruction_fetch_phase;

architecture Behavioral of instruction_fetch_phase is
signal PCin,PCout,add_out:std_logic_vector(31 downto 0);

begin

 PC: entity work.PC(Behavioral)
     Port map(
                en=>pc_en,
                q=>PCout,
                clk=>clks,
                d=>PCin
                );
                
   MUX: entity work.MUX(Behavioral)
         Port map(
               in1=>add_out,
               in2=>in_mux,
               sel=> pc_next_sel,
               out_mux=>PCin
                );
                
                     
   Instruction_mem: entity work.instruction_memory(Behavioral)
         Port map(
                address=>PCout,
                out_mem=>out1
                );
      sabirac:    entity work.sabirac(Behavioral)
         Port map(
               in1=>PCout,
               in2=>"00000000000000000000000000000100",
              out_add=>add_out
                );      
 out2<=PCout;
end Behavioral;
