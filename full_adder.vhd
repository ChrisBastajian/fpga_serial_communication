----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2025 06:42:34 PM
-- Design Name: 
-- Module Name: full_adder - Behavioral
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

entity full_adder is

    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
         cin : in STD_LOGIC;
           s : out STD_LOGIC;
        cout : out STD_LOGIC);
        
end full_adder;

architecture Behavioral of full_adder is

begin
       s <= x XOR y XOR cin;
    cout <= (x AND y) OR (y AND cin) OR (x AND cin);
end Behavioral;
