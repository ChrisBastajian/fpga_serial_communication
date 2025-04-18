-- Chris Bastajian
--This is a 1 to 3 demux (8 bit input and output)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.math_real.log2;
use ieee.math_real.ceil;

entity demux is
	port(
	   input: in std_logic_vector(7 downto 0);
	   sel: in std_logic_vector(1 downto 0);
	   A, B, op: out std_logic_vector(7 downto 0)
	);
end demux;

architecture Behavioral of demux is
    signal asig, bsig, opsig: std_logic_vector(7 downto 0);
begin
    with sel select
        A <= input when "00",
        asig when others;
    with sel select
        B <= input when "01",
        bsig when others;    
    with sel select
        op <= input when "10",
        opsig when others;  
        	
end Behavioral;

