library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity my_alu_arith is
	generic (N: INTEGER:= 8);
	port (A, B: in std_logic_vector (N-1 downto 0);
	         op: in std_logic_vector (1 downto 0);
	         y: out std_logic_vector (N-1 downto 0));
end my_alu_arith;

architecture structure of my_alu_arith is

	component my_addsub
		generic (N: INTEGER:= 8);
		port(	addsub   : in std_logic;
				x, y     : in std_logic_vector (N-1 downto 0);
				s        : out std_logic_vector (N-1 downto 0);
				overflow : out std_logic;
				cout     : out std_logic);
	end component;

	signal 
--	Ap1, 
--	Am1, 
--	Bp1, 
--	Bm1, 
	ApB, 
	AmB 
	: std_logic_vector (N-1 downto 0);
   signal my_one: std_logic_vector (N-1 downto 0);
	
begin

my_one(N-1 downto 1) <= (others => '0'); my_one(0) <= '1'; -- my_one = 1

--   -- A + 1
--   f0: my_addsub generic map (N => N)
--       port map (addsub => '0', x => A, y => my_one , s => Ap1);
--   
--   -- A - 1
--   f1: my_addsub generic map (N => N)
--       port map (addsub => '1', x => A, y => my_one , s => Am1);
--   
--   -- B + 1
--   f2: my_addsub generic map (N => N)
--       port map (addsub => '0', x => B, y => my_one , s => Bp1);
--   	 
--   -- B - 1	 
--   f3: my_addsub generic map (N => N)
--       port map (addsub => '1', x => B, y => my_one , s => Bm1);
--
-- A + B
f4: my_addsub generic map (N => N)
    port map (addsub => '0', x => A, y => B , s => ApB);

-- A - B
f5: my_addsub generic map (N => N)
    port map (addsub => '1', x => A, y => B , s => AmB);	 


process(op, ApB, AmB)
    begin
        case op is
            when "00" =>
                y <= ApB;
            when "01" =>
                y <= AmB;
            when others =>
                y <= (others => '0');
        end case;
    end process;	 
end structure; 

	 
-- Multiplexor	 
-- with op select
--		y <=  
--		      A   when "000",
--		      Ap1 when "001",
--			  Am1 when "010",
--			  B   when "011",
--			  Bp1 when "100",
--			  Bm1 when "101",
--			  ApB when "00",
--			  AmB when "01",
--			  (others => '0') when others;









------------------------------------------------------------------------
 --   -- Safe, synthesis-friendly logic
    


