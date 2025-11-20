----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2025 04:26:19 AM
-- Design Name: 
-- Module Name: top_Rx - Behavioral
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.math_real.log2;
use ieee.math_real.ceil;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_Rx is
  Port (
        clk, resetn, RXD: in std_logic;
        doneRx: out std_logic
   );
end top_Rx;

architecture Behavioral of top_Rx is
    component counter
        --generic (COUNT: INTEGER:= (10**8)/2); -- (10**8)/2 cycles of T = 10 ns --> 0.5 s
        generic (COUNT: INTEGER:= (10**2)/2); -- (10**2)/2 cycles of T = 10 ns --> 0.5us
        port (clock, resetn, E, sclr: in std_logic;
                Q: out std_logic_vector ( integer(ceil(log2(real(COUNT)))) - 1 downto 0);
                z: out std_logic);
    end component;
    component FSM_Rx
     Port ( 
            resetn, zC, RXD, clock: in std_logic;
            EC, doneRx: out std_logic:='0'        
            );
    end component;
    
    --signals:
    signal ecsig, zcsig: std_logic;
begin
    C1: counter generic map (count => 10417) port map(clock=>clk,resetn=>resetn,E=>ECsig,sclr=>'0',z=>ZCsig);--10416.666
    rx_fsm: fsm_rx port map(resetn=>resetn, zc=>zcsig, rxd=>RXD, clock=>clk, EC=>ecsig, doneRx=>doneRx); 
end Behavioral;
