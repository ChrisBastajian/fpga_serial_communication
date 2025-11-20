----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Chris Basterma aghanjanjanjanian
-- 
-- Create Date: 03/17/2024 03:06:43 PM
-- Design Name: 
-- Module Name: FSM_Ser - Behavioral
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

entity FSM_Rx is
 Port ( 
        resetn, zC, RXD, clock: in std_logic;
        EC, doneRx: out std_logic:='0'        
        );
end FSM_Rx;

architecture Behavioral of FSM_Rx is

type state is (S1, s2);
	signal y: state;
	
begin

Transitions: process(resetn, zC, clock)
    begin
        if resetn = '0' then --asynchronous signal
            y<= s1; --initial state
        elsif (clock'event and clock='1') then
            case y is
                when s1 => if RXD = '0' then y<= s2; else y<= s1; end if; --start bit
                when s2 => if zc<='1' then y<=s1; else y<=s2; end if;
            end case;
        end if;
     end process;

Outputs: process(y)
    begin
        --Default values are '0'
        doneRx<='0'; ec<='0';
        case y is
            when s1=> null;
            when s2=> doneRx<='1'; ec<='1';                
        end case;
    end process;
	

end Behavioral;
