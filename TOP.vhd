----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2025 05:51:19 PM
-- Design Name: 
-- Module Name: TOP - Behavioral
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

entity TOP is
    Port (
        clk    : in STD_LOGIC;
        rx     : in STD_LOGIC;
        tx     : out STD_LOGIC
    );
end TOP;

architecture Behavioral of TOP is

    signal A, B       : STD_LOGIC_VECTOR(3 downto 0);
    signal sel        : STD_LOGIC_VECTOR(1 downto 0);
    signal result     : STD_LOGIC_VECTOR(3 downto 0);
    signal rx_data    : STD_LOGIC_VECTOR(7 downto 0);
    signal tx_data    : STD_LOGIC_VECTOR(7 downto 0);
    signal data_ready : STD_LOGIC;
    signal tx_start   : STD_LOGIC;

    COMPONENT UART_RX
        Port (
            clk        : in  STD_LOGIC;
            rx         : in  STD_LOGIC;
            data_out   : out STD_LOGIC_VECTOR(7 downto 0);
            data_ready : out STD_LOGIC
        );
    END COMPONENT;

    COMPONENT UART_TX
        Port (
            clk       : in  STD_LOGIC;
            data_in   : in  STD_LOGIC_VECTOR(7 downto 0);
            tx        : out STD_LOGIC;
            tx_start  : in  STD_LOGIC
        );
    END COMPONENT;

    COMPONENT MUX_4_TO_1
        Port (
            AxnorB          : in STD_LOGIC_VECTOR(3 downto 0);
            AnorB           : in STD_LOGIC_VECTOR(3 downto 0);
            A_PLUS_B        : in STD_LOGIC_VECTOR(3 downto 0);
            ABS_A_Minus_B   : in STD_LOGIC_VECTOR(3 downto 0);
            Sel             : in STD_LOGIC_VECTOR(1 downto 0);
            output          : out STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;

    COMPONENT AxnorB
        Port (
            A : in STD_LOGIC_VECTOR(3 downto 0);
            B : in STD_LOGIC_VECTOR(3 downto 0);
            R : out STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;

    COMPONENT AnorB
        Port (
            A : in STD_LOGIC_VECTOR(3 downto 0);
            B : in STD_LOGIC_VECTOR(3 downto 0);
            R : out STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;

    COMPONENT adder4
        Port (
            A : in STD_LOGIC_VECTOR(3 downto 0);
            B : in STD_LOGIC_VECTOR(3 downto 0);
            cin : in STD_LOGIC;
            R : out STD_LOGIC_VECTOR(3 downto 0);
            cout : out STD_LOGIC
        );
    END COMPONENT;

    COMPONENT absolute_difference
        Port (
            A : in STD_LOGIC_VECTOR(3 downto 0);
            B : in STD_LOGIC_VECTOR(3 downto 0);
            X : out STD_LOGIC_VECTOR(4 downto 0)
        );
    END COMPONENT;

begin

    UART_RECEIVER: UART_RX port map(clk => clk, rx => rx, data_out => rx_data, data_ready => data_ready);
    UART_TRANSMITTER: UART_TX port map(clk => clk, data_in => tx_data, tx => tx, tx_start => tx_start);

    PROCESS (clk)
    begin
        if rising_edge(clk) then
            if data_ready = '1' then
                A <= rx_data(7 downto 4);
                B <= rx_data(3 downto 0);
                sel <= rx_data(5 downto 4); -- Fixing incorrect indexing for sel
            end if;
        end if;
    END PROCESS;

    MUX_UNIT: MUX_4_TO_1 port map(
        AxnorB => A,
        AnorB => B,
        A_PLUS_B => (others => '0'),
        ABS_A_Minus_B => (others => '0'),
        Sel => sel,
        output => result
    );

    PROCESS (clk)
    begin
        if rising_edge(clk) then
            tx_data <= "0000" & result;
            tx_start <= '1';
        end if;
    END PROCESS;

end Behavioral;
