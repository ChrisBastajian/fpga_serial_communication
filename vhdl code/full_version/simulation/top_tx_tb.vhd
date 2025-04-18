
library ieee;
use ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
entity top_tx_tb IS
end top_tx_tb;
 
architecture behavior of top_tx_tb is 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    component uart_tx
        port(resetn : IN  std_logic;
             clock : IN  std_logic;
             E : IN  std_logic;
             SW : IN  std_logic_vector(7 downto 0);
             TXD : OUT  std_logic);
    end component;
    

   --Inputs
   signal resetn : std_logic := '0';
   signal clock : std_logic := '0';
   signal E : std_logic := '0';
   signal SW : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal TXD : std_logic;

   -- Clock period definitions
   constant T : time := 10 ns;
 
begin
 
	-- Instantiate the Unit Under Test (UUT)
   uut: uart_tx port map (
          resetn => resetn,
          clock => clock,
          E => E,
          SW => SW,
          TXD => TXD
        );

   -- Clock process
   clock_proc :process
   begin
		clock <= '0';
		wait for T/2;
		clock <= '1';
		wait for T/2;
   end process;
 

   -- Stim process
   stim_proc: process
   begin
      wait for 100 ns;	
		resetn  <= '1';
      wait for T*10;
		E <= '1'; SW <= x"E5"; wait for T*6;
		E <= '0';

      -- insert stimulus here
   end process;

end;
