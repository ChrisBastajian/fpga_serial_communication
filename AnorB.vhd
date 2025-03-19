----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2025 08:17:48 PM
-- Design Name: 
-- Module Name: AnorB - Behavioral
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

entity AnorB is

       Port ( A : in STD_LOGIC_VECTOR(3 downto 0);
              B : in STD_LOGIC_VECTOR(3 downto 0);
              R : out STD_LOGIC_VECTOR(3 downto 0));
              
end AnorB;

architecture Behavioral of AnorB is

begin

R <= A nor B;

end Behavioral;
