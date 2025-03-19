----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2025 06:48:28 PM
-- Design Name: 
-- Module Name: UART_TX - Behavioral
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

entity UART_TX is
    Generic (
        CLK_FREQ    : integer := 100000000; -- System clock frequency
        BAUD_RATE   : integer := 9600       -- Baud rate
    );
    Port (
        clk       : in  STD_LOGIC;
        data_in   : in  STD_LOGIC_VECTOR(7 downto 0);
        tx        : out STD_LOGIC;
        tx_start  : in  STD_LOGIC
    );
end UART_TX;

architecture Behavioral of UART_TX is
    constant BIT_PERIOD : integer := CLK_FREQ / BAUD_RATE;
    signal bit_count : integer range 0 to 10 := 0;
    signal shift_reg : STD_LOGIC_VECTOR(9 downto 0) := (others => '1');
    signal tx_clk_div : integer := 0;
    signal transmitting : STD_LOGIC := '0';

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if transmitting = '0' and tx_start = '1' then
                transmitting <= '1';
                shift_reg <= '1' & data_in & '0'; -- Start bit, data, stop bit
                bit_count <= 0;
                tx_clk_div <= BIT_PERIOD;
            elsif transmitting = '1' then
                if tx_clk_div = 0 then
                    tx_clk_div <= BIT_PERIOD;
                    if bit_count < 10 then
                        tx <= shift_reg(bit_count);
                        bit_count <= bit_count + 1;
                    else
                        transmitting <= '0';
                        tx <= '1'; -- Idle state
                    end if;
                else
                    tx_clk_div <= tx_clk_div - 1;
                end if;
            end if;
        end if;
    end process;
end Behavioral;