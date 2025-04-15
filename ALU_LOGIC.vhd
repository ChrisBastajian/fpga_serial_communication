library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity my_alu_logic is
   generic (N: INTEGER:= 8);
	port ( A, B: in std_logic_vector (N-1 downto 0);
			  op: in std_logic_vector (1 downto 0);
	          y: out std_logic_vector (N-1 downto 0));
end my_alu_logic;

architecture structure of my_alu_logic is

begin

	--   with op select
	--		y <=  
	--		      not (A)   when "000",
	--		      not (B)   when "001",
	--			  A and B   when "10",
	--			  A or  B   when "11";
	--			  A nand B  when "100",
	--			  A nor B   when "101",
	--			  A xor B   when "110",
	--			  A xnor B  when "111",
	--			  (others => '0') when others;
	
          process(op, A, B)
              begin
                  case op is
                      when "10" =>
                          y <= A and B;   
                      when "11" =>
                          y <= A or B;
                      when others =>
                          y <= (others => '0');
                  end case;
              end process;
end structure;