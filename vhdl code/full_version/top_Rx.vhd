----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Chris BastermaAGHAJANJANIAN
-- 
-- Create Date: 04/08/2025 07:03:04 PM
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
        doneRx: out std_logic;
        EQt, zQt, ECt, zCt, ESRt, LSRt, sclrt, ERA,ERB,erc: out std_logic;
        A, B, op: out std_logic_vector(7 downto 0)
   );
end top_Rx;

architecture Behavioral of top_Rx is
    component my_pashiftreg_sclr
       generic (N: INTEGER:= 4;
                 DIR: STRING:= "LEFT");
        port ( clock, resetn: in std_logic;
               din, E, sclr, s_l: in std_logic; -- din: shiftin input
                 D: in std_logic_vector (N-1 downto 0);
               Q: out std_logic_vector (N-1 downto 0);
              shiftout: out std_logic);
    end component;
    component my_rege
       generic (N: INTEGER:= 4);
        port ( clock, resetn: in std_logic;
               E, sclr: in std_logic; -- sclr: Synchronous clear
                 D: in std_logic_vector (N-1 downto 0);
               Q: out std_logic_vector (N-1 downto 0));
    end component;
    component timer
        --generic (COUNT: INTEGER:= (10**8)/2); -- (10**8)/2 cycles of T = 10 ns --> 0.5 s
        generic (COUNT: INTEGER:= (10**2)/2); -- (10**2)/2 cycles of T = 10 ns --> 0.5us
        port (clock, resetn, E, sclr: in std_logic;
                Q: out std_logic_vector ( integer(ceil(log2(real(COUNT)))) - 1 downto 0);
                z: out std_logic);
    end component;    
    component counter
        --generic (COUNT: INTEGER:= (10**8)/2); -- (10**8)/2 cycles of T = 10 ns --> 0.5 s
        generic (COUNT: INTEGER:= (10**2)/2); -- (10**2)/2 cycles of T = 10 ns --> 0.5us
        port (clock, resetn, E, sclr: in std_logic;
                Q: out std_logic_vector ( integer(ceil(log2(real(COUNT)))) - 1 downto 0);
                z: out std_logic);
    end component;
    component demux
        port(
           input: in std_logic_vector(7 downto 0);
           sel: in std_logic_vector(1 downto 0);
           A, B, op: out std_logic_vector(7 downto 0)
        );
    end component;
    component FSM_Rx
     Port ( 
            resetn, zC, zQ, RXD, clock: in std_logic;
            ESR, EQ, EC, ERA, ERB, ERC, LSR, doneRx, sclr: out std_logic:='0';
            sel: out std_logic_vector(1 downto 0):="00"
            );
    end component;
    component FSM_UART_RX
        Port (
            resetn, zC, clock   : in std_logic;    
            RXD      : in std_logic; --RXD input from UART chip    
            RXD_out, EC  : out std_logic    
        );
    end component;
    
    signal EQ, zQ, EC, zC, ESR, LSR, sclr, era_sig, erb_sig, erc_sig: std_logic;
    signal sel: std_logic_vector(1 downto 0);
    signal Q, asig, bsig, opsig: std_logic_vector(7 downto 0);
    signal RXDout, zc_uart, ec_uart: std_logic;
    
begin    
-- storing signals:
EQt <= EQ; zQt<=zQ; ECt<=ec; zct<=zc; esrt<=esr; lsrt<= lsr; sclrt<=sclr; erA<=era_sig;
erb<=erb_sig; erc<=erc_sig;
--Timer Counter:
C1: counter generic map (count => 1) port map(clock=>clk,resetn=>resetn,E=>EC,sclr=>'0',z=>ZC);   
--Bit Counter:
C2: counter generic map (count => 8) port map(clock=>clk,resetn=>resetn,E=>EQ,sclr=>'0',z=>ZQ);

shift_reg: my_pashiftreg_sclr generic map(N => 8, DIR => "RIGHT") 
                              port map(clock=>clk,resetn=>resetn,din=>RXDout,E=>ESR,sclr=>sclr,s_l=>LSR,
                                        Q=>Q, d=>"00000000");

results_seperation: demux port map(input=>Q, sel=>sel, A=>asig, B=>bsig, op=>opsig);

regA: my_rege generic map(N => 8) 
                port map(clock=>clk, resetn=>resetn, E=>ERA_sig, sclr=>sclr, D=>asig, Q=>A);
regB: my_rege generic map(N => 8) 
                port map(clock=>clk, resetn=>resetn, E=>ERb_sig, sclr=>sclr, D=>bsig, Q=>B);
regOP: my_rege generic map(N => 8) 
                port map(clock=>clk, resetn=>resetn, E=>ERc_sig, sclr=>sclr, D=>opsig, Q=>op);

RXFSm: FSM_Rx port map(resetn=>resetn, zC=>zC, zQ=>zQ, RXD=>RXDout, clock=>clk,
                        ESR=>ESR, EQ=>EQ, EC=>EC, ERA=>ERA_sig,ERB=>erb_sig,
                        erc=>erc_sig, LSR=>LSR, doneRx=>doneRx,
                        sclr=>sclr, sel=>sel);
                        

Cuart: counter generic map (count => 1) port map(clock=>clk,resetn=>resetn,E=>EC_uart,sclr=>'0',z=>ZC_uart);                      
UARTFSM: FSM_UART_RX port map(resetn=>resetn, zc=>zc_uart, clock=>clk, rxd=>rxd, rxd_out=>rxdout, ec=>ec_uart);
end Behavioral;
