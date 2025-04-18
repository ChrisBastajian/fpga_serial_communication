----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2025 05:17:36 PM
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
  Port (
        clk, resetn, rx: in std_logic;
        tx, done: out std_logic
   );
end top;

architecture Behavioral of top is
    component top_Rx
      Port (
            clk, resetn, RXD: in std_logic;
            doneRx: out std_logic;
            EQt, zQt, ECt, zCt, ESRt, LSRt, sclrt, ERA,ERB,erc: out std_logic;
            A, B, op: out std_logic_vector(7 downto 0)
       );
    end component;    
    component top_tx
                Port(
                    E, clock, resetn: in std_logic;
                    SW: in std_logic_vector (7 downto 0);
                    TXD, done: out std_logic
                );
    end component;
    component my_alu
        generic (N: INTEGER:= 8);
        port (A, B: in std_logic_vector (N-1 downto 0);
                op: in std_logic_vector (1 downto 0);
            DoneRX: in std_logic;
                ET: out std_logic;
               SWT: out std_logic_vector (N-1 downto 0));
    end component;
    signal donerx, etsig: std_logic;
    signal op_twobit: std_logic_vector(1 downto 0);
    signal asig, bsig, opsig, swt: std_logic_vector(7 downto 0);
        
begin
    op_twobit <= opsig(7 downto 6);
    rx_component: top_Rx port map(clk=>clk, resetn=>resetn, RXD=>rx, donerx=>donerx, A=>asig, b=>bsig, op=>opsig);
    alu_computation: my_alu port map(a=>asig, b=>bsig, op=>op_twobit, donerx=>donerx, et=>etsig, swt=>swt);
    tx_component: top_tx port map(E=> etsig, clock=>clk, resetn=>resetn, sw=>swt, txd=>tx, done=>done);
end Behavioral;
