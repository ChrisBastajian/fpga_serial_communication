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
        resetn, zC, zQ, RXD, clock: in std_logic;
        ESR, EQ, EC, ERA, ERB, ERC, LSR, doneRx, sclr: out std_logic:='0';
        sel: out std_logic_vector(1 downto 0):="00"
        );
end FSM_Rx;

architecture Behavioral of FSM_Rx is

type state is (S1, S2, S3, s4, s5, s6, s7);
	signal y: state;
	
begin

Transitions: process(resetn, RxD, zQ, zC, clock)
    begin
        if resetn = '0' then --asynchronous signal
            y<= s1; --initial state
        elsif (clock'event and clock='1') then
            case y is
                when s1 => if RXD = '0' then y<= s2; else y<= s1; end if; --start bit
                when s2 => if zC = '1' then if zQ ='1' then y<=s6; else y<= s2; end if; else y<= s2; end if;
                when s6 => if RXD = '0' then y<= s3; else y<=s6; end if; --wait for next start bit
                when s3 => if zC = '1' then if zQ ='1' then y<=s7; else y<= s3; end if; else y<= s3; end if;
                when s7 => if RXD = '0' then y<= s4; else y<=s7; end if; --wait for next start bit
                when s4 => if zC = '1' then if zQ ='1' then y<=s5; else y<= s4; end if; else y<= s4; end if;
                when s5 => if RXD = '0' then y<= s2; else y<= s5; end if;
            end case;
        end if;
     end process;

Outputs: process(y, RXD, zc, zq)
    begin
        --Default values are '0'
        ESR    <= '0';
        EQ     <= '0';
        EC     <= '0';
        ERA     <= '0';
        ERB <='0';
        ERC <= '0';
        LSR    <= '0';
        doneRx <= '0';
        sclr   <= '0';
        case y is
            when s1=> sel<="00"; if RXD = '0' then ESR<='1';sclr<='1';end if;
            when s2=> sel<="00"; if zC='0' then EC<='1'; else EC<='1'; end if;
                        if zQ = '0' then ESR<='1'; EQ<='1'; else ESR<='1'; EQ<='1';ERA<='1'; end if;
            when s3=> sel<="01"; if zC='0' then EC<='1'; else EC<='1'; end if;
                        if zQ = '0' then ESR<='1'; EQ<='1'; else ESR<='1'; EQ<='1';ERB<='1'; end if;
            when s4=> sel<="10"; if zC='0' then EC<='1'; else EC<='1'; end if;
                        if zQ = '0' then ESR<='1'; EQ<='1'; else EQ<='1';ERC<='1'; end if;
            when s5=> doneRx<='1'; if RXD = '0' then ESR<='1'; sclr<='1'; end if;  
            when s6=>         
                ESR    <= '0';
                EQ     <= '0';
                EC     <= '0';
                ERA     <= '0';
                ERb     <= '0';
                ERc     <= '0';                                
                LSR    <= '0';
                doneRx <= '0';
            when s7=>
                ESR    <= '0';
                EQ     <= '0';
                EC     <= '0';
                ERA     <= '0';
                ERb     <= '0';
                ERc     <= '0'; 
                LSR    <= '0';
                doneRx <= '0';                       
        end case;
    end process;
	

end Behavioral;
