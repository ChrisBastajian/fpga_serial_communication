library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM_UART_RX is
    Port (
        resetn, zC, clock   : in std_logic;    
        RXD      : in std_logic; --RXD input from UART chip    
        RXD_out, EC  : out std_logic    
    );
end FSM_UART_RX;

architecture Behavioral of FSM_UART_RX is
    type state is (s_idle, s_receive);
    signal y : state := s_idle;
    
begin
Transitions : process(clock, resetn)
begin
    if resetn = '0' then
        y <= s_idle;
    elsif (clock'event and clock='1') then
        case y is
            when S_idle =>
                y <= s_receive;

            when S_receive =>
                y <= s_receive; 
        end case;
    end if;
end process;


Outputs : process(y, zC, RXD)
begin
    -- Default outputs
    EC       <= '0';
    RXD_out  <= RXD; --sends out RXD input that is being read

    case y is
        when S_idle => null;
        when S_receive => if zC = '1' then EC <= '1'; end if;
    end case;
end process;

end Behavioral;
