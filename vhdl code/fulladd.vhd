library ieee;
use ieee.std_logic_1164.all;

entity fulladd is
	port( cin, x, y : in std_logic;
         s, cout   : out std_logic);
end fulladd;

architecture structure of fulladd is

begin

	s <= x xor y xor cin;
	cout <= (x and y) or (x and cin) or (y and cin);
	
end structure;