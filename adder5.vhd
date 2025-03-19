----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2025 06:43:06 PM
-- Design Name: 
-- Module Name: adder5 - Behavioral
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

entity adder5 is
    Port ( A : in STD_LOGIC_VECTOR(4 downto 0);
           B : in STD_LOGIC_VECTOR(4 downto 0);
           cin : in STD_LOGIC;
           R : out STD_LOGIC_VECTOR(4 downto 0);
           cout : out STD_LOGIC);
end adder5;

architecture Behavioral of adder5 is
    component full_adder
        Port ( x : in STD_LOGIC;
               y : in STD_LOGIC;
               cin : in STD_LOGIC;
               s : out STD_LOGIC;
               cout : out STD_LOGIC);
    end component;

    signal c : STD_LOGIC_VECTOR(4 downto 0);
begin
    FA0: full_adder port map(x => A(0), y => B(0), cin => cin, s => R(0), cout => c(0));
    FA1: full_adder port map(A(1), B(1), c(0), R(1), c(1));
    FA2: full_adder port map(A(2), B(2), c(1), R(2), c(2));
    FA3: full_adder port map(A(3), B(3), c(2), R(3), c(3));
    FA4: full_adder port map(A(4), B(4), c(3), R(4), cout);
end Behavioral;
