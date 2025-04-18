----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2025 04:52:55 AM
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

entity top is
    Port ( 
        clk, resetn, RXD: in std_logic;
        op: in std_logic_vector(1 downto 0);
        A, B: in std_logic_vector(7 downto 0);
        TXD, done: out std_logic
    );
end top;

architecture Behavioral of top is
    component alutx_top 
        generic (N: INTEGER:= 8);
        Port (
              clk, resetn, E: in std_logic;
              op: in STD_LOGIC_VECTOR (1 downto 0);
              A, B: in STD_LOGIC_VECTOR (N-1 downto 0);
              tx, done: out std_logic;
              an: out STD_LOGIC_VECTOR (3 downto 0)
       );
    end component;
    component top_Rx
      Port (
            clk, resetn, RXD: in std_logic;
            doneRx: out std_logic
       );
    end component;    
    
    signal doneRx: std_logic;
    signal an: std_logic_vector(3 downto 0);
begin
    rx: top_Rx port map(clk=>clk, resetn=>resetn, RXD=>RXD, doneRx=>doneRx);
    alutx: alutx_top port map(clk=>clk, resetn=>resetn, E=>doneRx, op=>op, A=>A, B=>B, tx=>TXD, done=>done, an=>an);
end Behavioral;
