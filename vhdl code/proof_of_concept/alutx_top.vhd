----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2025 05:17:36 PM
-- Design Name: 
-- Module Name: top - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alutx_top is
    generic (N: INTEGER:= 8);
    Port (
          clk, resetn, E: in std_logic;
          op: in STD_LOGIC_VECTOR (1 downto 0);
          A, B: in STD_LOGIC_VECTOR (N-1 downto 0);
          tx, done: out std_logic;
          an: out STD_LOGIC_VECTOR (3 downto 0)
   );
end alutx_top;

architecture Behavioral of alutx_top is

component top_tx is
            Port (clock, resetn, E: in std_logic;
            SW, A, B: in std_logic_vector (7 downto 0);
            tx, done: out std_logic);
end component;

component my_alu is
generic (N: INTEGER:= N);
port (A, B: in std_logic_vector (N-1 downto 0);
        op: in std_logic_vector (1 downto 0);
       SWT: out std_logic_vector (N-1 downto 0));
end component;

signal P: STD_LOGIC_VECTOR (7 downto 0);
        
begin
    tx_component: top_tx port map(E=> E, clock=>clk, resetn=>resetn, sw=>P,A=>A, B=>B, tx=>tx, done=>done);
    
    alu: my_alu generic map (N => N)
     port map (A => A, B => B, op => op, SWT => P);

an <= "1110";
end Behavioral;