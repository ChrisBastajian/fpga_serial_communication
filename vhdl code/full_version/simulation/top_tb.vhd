----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2025 06:07:11 PM
-- Design Name: 
-- Module Name: top_tb - Behavioral
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

entity top_tb is
--  Port ( );
end top_tb;

architecture Behavioral of top_tb is
    component top
      Port (
            clk, resetn, rx: in std_logic;
            tx, done: out std_logic
       );
    end component;    
        -- Clock period definitions
    constant clk_period : time := 10 ns;
    
    -- Signals
    signal clk : std_logic := '0';
    signal resetn : std_logic := '0';
    signal RXD, TXD : std_logic := '1';
    signal done : std_logic;   
begin
    uut: top port map(
        clk=>clk, 
        resetn=>resetn,
        rx=>rxd,
        tx=>txd,
        done=>done                    
    );
    
        -- Clock process
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
    end process;
    
    -- Stimulus process
    stim_proc: process
    begin	
        -- Reset sequence
        resetn <= '0';
        wait for 20 ns;
        resetn <= '1';
        wait for 20 ns;
        
        RXD <= '0'; -- Start bit
        wait for clk_period; 
        RXD <= '1'; wait for clk_period;
        RXD <= '0'; wait for clk_period;
        RXD <= '1'; wait for clk_period;
        RXD <= '0'; wait for clk_period;
        RXD <= '0'; wait for clk_period;
        RXD <= '1'; wait for clk_period;
        RXD <= '0'; wait for clk_period;
        RXD <= '1'; wait for clk_period;
        RXD <= '1'; -- Stop bit
        wait for clk_period;
        
        -- Transmit second byte (0x3C)
        RXD <= '0'; -- Start bit
        wait for clk_period;
        RXD <= '0'; wait for clk_period;
        RXD <= '0'; wait for clk_period;
        RXD <= '1'; wait for clk_period;
        RXD <= '1'; wait for clk_period;
        RXD <= '1'; wait for clk_period;
        RXD <= '0'; wait for clk_period;
        RXD <= '0'; wait for clk_period;
        RXD <= '0'; wait for clk_period;
        RXD <= '1'; -- Stop bit
        wait for clk_period;
        
        -- Transmit third byte (0x7F)
        RXD <= '0'; -- Start bit
        wait for clk_period;
        RXD <= '0'; wait for clk_period;
        RXD <= '0'; wait for clk_period;
        RXD <= '0'; wait for clk_period;
        RXD <= '0'; wait for clk_period;
        RXD <= '0'; wait for clk_period;
        RXD <= '0'; wait for clk_period;
        RXD <= '1'; wait for clk_period;
        RXD <= '0'; wait for clk_period;
        RXD <= '1'; -- Stop bit
        wait for clk_period;
        --Wait for doneRx
        wait until done = '1';
        wait;
    end process;
end Behavioral;
