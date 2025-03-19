----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2025 06:43:42 PM
-- Design Name: 
-- Module Name: absolute_difference - Behavioral
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

entity absolute_difference is
    Port ( A : in STD_LOGIC_VECTOR(3 downto 0);
           B : in STD_LOGIC_VECTOR(3 downto 0);
           X : out STD_LOGIC_VECTOR(4 downto 0));
end absolute_difference;

architecture Behavioral of absolute_difference is
    component adder5
        Port ( A : in STD_LOGIC_VECTOR(4 downto 0);
               B : in STD_LOGIC_VECTOR(4 downto 0);
               cin : in STD_LOGIC;
               R : out STD_LOGIC_VECTOR(4 downto 0);
               cout : out STD_LOGIC);
    end component;

    signal R : STD_LOGIC_VECTOR(4 downto 0);
    signal R_xor : STD_LOGIC_VECTOR(4 downto 0);
    signal B_ext2 : STD_LOGIC_VECTOR(4 downto 0);
    signal B_ext : STD_LOGIC_VECTOR(4 downto 0);
    signal A_ext : STD_LOGIC_VECTOR(4 downto 0);
begin
    B_ext2 <= NOT B_ext;
    B_ext <= '0'&B(3 downto 0);
    A_ext <= '0'&A(3 downto 0);
    Subtract: adder5 port map(A => A_ext, B => B_ext2, cin => '1', R => R, cout => open);
    Absolute: adder5 port map(A => R_xor, B => (others => '0'), cin => R(4), R => X, cout => open);
    R_xor(0) <= R(0) xor R(4);
    R_xor(1) <= R(1) xor R(4);
    R_xor(2) <= R(2) xor R(4);
    R_xor(3) <= R(3) xor R(4);
    R_xor(4) <= R(4) xor R(4);
    
end Behavioral;