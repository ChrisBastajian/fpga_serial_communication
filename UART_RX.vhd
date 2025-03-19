----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2025 06:48:04 PM
-- Design Name: 
-- Module Name: UART_RX - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UART_RX is
    Generic (
        CLK_FREQ    : integer := 100000000; -- System clock frequency
        BAUD_RATE   : integer := 9600       -- Baud rate
    );
    Port (
        clk        : in  STD_LOGIC;
        rx         : in  STD_LOGIC;
        data_out   : out STD_LOGIC_VECTOR(7 downto 0);
        data_ready : out STD_LOGIC
    );
end UART_RX;

architecture Behavioral of UART_RX is
    constant BIT_PERIOD : integer := CLK_FREQ / BAUD_RATE;
    signal bit_count : integer range 0 to 10 := 0;
    signal shift_reg : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal rx_buffer: STD_LOGIC := '1';
    signal rx_clk_div : integer := 0;
    signal receiving : STD_LOGIC := '0';

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if receiving = '0' and rx = '0' then
                receiving <= '1';
                rx_clk_div <= BIT_PERIOD / 2;
                bit_count <= 0;
            elsif receiving = '1' then
                if rx_clk_div = 0 then
                    rx_clk_div <= BIT_PERIOD;
                    if bit_count < 10 then
                        bit_count <= bit_count + 1;
                        if bit_count > 0 and bit_count < 9 then
                            shift_reg(bit_count - 1) <= rx;
                        end if;
                    else
                        data_out <= shift_reg;
                        data_ready <= '1';
                        receiving <= '0';
                    end if;
                else
                    rx_clk_div <= rx_clk_div - 1;
                end if;
            else
                data_ready <= '0';
            end if;
        end if;
    end process;
end Behavioral;