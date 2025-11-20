library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity my_alu is
	generic (N: INTEGER:= 8);
	port (A, B: in std_logic_vector (N-1 downto 0);
			op: in std_logic_vector (1 downto 0);
	    DoneRX: in std_logic;
	        ET: out std_logic;
		   SWT: out std_logic_vector (N-1 downto 0));
end my_alu;

architecture structure of my_alu is

	component my_alu_arith
		generic (N: INTEGER:= 8);
		port (A, B: in std_logic_vector (N-1 downto 0);
					op: in std_logic_vector (1 downto 0);
					y: out std_logic_vector (N-1 downto 0));
	end component;
	
	component my_alu_logic
		generic (N: INTEGER:= 8);
		port ( A, B: in std_logic_vector (N-1 downto 0);
				  op: in std_logic_vector (1 downto 0);
					 y: out std_logic_vector (N-1 downto 0));
	end component;

	signal ya, yb: std_logic_vector (N-1 downto 0);
begin

ET <= DoneRX;

f1: my_alu_arith generic map (N => N)
    port map (A => A, B => B, op => op (1 downto 0), y => ya);
	 
f2: my_alu_logic generic map (N => N)
    port map (A => A, B => B, op => op (1 downto 0), y => yb);
	  
	  
	 process(op, ya, yb)
        begin
            case op is
                when "00" | "01" =>
                    SWT <= ya;
                when others =>
                    SWT <= yb;
            end case;
     end process;

	-- with op select
	--		y <= ya when "00", "01",
	--		     yb when others;

end structure;