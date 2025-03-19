----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2025 08:42:17 PM
-- Design Name: 
-- Module Name: MUX_4_TO_1 - Behavioral
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

entity MUX_4_TO_1 is

       Port ( AxnorB : in STD_LOGIC_VECTOR(3 downto 0);
               AnorB : in STD_LOGIC_VECTOR(3 downto 0);
            A_PLUS_B : in STD_LOGIC_VECTOR(3 downto 0);
        ABS_A_Minus_B: in STD_LOGIC_VECTOR(3 downto 0);
                 Sel : in STD_LOGIC_VECTOR(1 downto 0);
             output : out STD_LOGIC_VECTOR(3 downto 0));
end MUX_4_TO_1;

architecture Behavioral of MUX_4_TO_1 is

begin   

with Sel select
    output <= 
            AxnorB when "00",
            AnorB when "01",
            A_PLUS_B when "10",
            ABS_A_Minus_B when others;
    
end Behavioral;
