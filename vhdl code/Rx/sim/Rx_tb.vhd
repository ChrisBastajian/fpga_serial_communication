library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Rx_tb is
end Rx_tb;

architecture behavior of Rx_tb is
    signal EQt, zQt, ECt, zCt, ESRt, LSRt, sclrt, ERA,ERB,ERc: std_logic;

    -- Component Declaration for the Unit Under Test (UUT)
    component top_Rx
      Port (
            clk, resetn, RXD: in std_logic;
            doneRx: out std_logic;
            EQt, zQt, ECt, zCt, ESRt, LSRt, sclrt, ERA,ERB,erc: out std_logic;
            A, B, op: out std_logic_vector(7 downto 0)
       );
    end component;
    
    -- Clock period definitions
    constant clk_period : time := 10 ns;
    
    -- Signals
    signal clk : std_logic := '0';
    signal resetn : std_logic := '0';
    signal RXD : std_logic := '1';
    signal doneRx : std_logic;
    signal A, B, op : std_logic_vector(7 downto 0);
    
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: top_Rx port map (
        clk => clk,
        resetn => resetn,
        RXD => RXD,
        doneRx => doneRx,
        EQt => EQt,
        zQt => zQt,
        ECt => ECt,
        zCt => zCt,
        ESRt => ESRt,
        LSRt => LSRt,
        sclrt => sclrt,
        ERa => ERa,
        ERb=>erb,
        erc=>erc,
        A => A,
        B => B,
        op => op
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
        
        -- Transmit first byte (0xA5)
--        RXD <= '0'; -- Start bit
--         ns; -- Bit duration for 9600 baud
--        RXD <= '1'; wait for 104160 ns;
--        RXD <= '0'; wait for 104160 ns;
--        RXD <= '1'; wait for 104160 ns;
--        RXD <= '0'; wait for 104160 ns;
--        RXD <= '0'; wait for 104160 ns;
--        RXD <= '1'; wait for 104160 ns;
--        RXD <= '0'; wait for 104160 ns;
--        RXD <= '1'; wait for 104160 ns;
--        RXD <= '1'; -- Stop bit
--        wait for 104160 ns;
        
--        -- Transmit second byte (0x3C)
--        RXD <= '0'; -- Start bit
--        wait for 104160 ns;
--        RXD <= '0'; wait for 104160 ns;
--        RXD <= '0'; wait for 104160 ns;
--        RXD <= '1'; wait for 104160 ns;
--        RXD <= '1'; wait for 104160 ns;
--        RXD <= '1'; wait for 104160 ns;
--        RXD <= '0'; wait for 104160 ns;
--        RXD <= '0'; wait for 104160 ns;
--        RXD <= '0'; wait for 104160 ns;
--        RXD <= '1'; -- Stop bit
--        wait for 104160 ns;
        
--        -- Transmit third byte (0x7F)
--        RXD <= '0'; -- Start bit
--        wait for 104160 ns;
--        RXD <= '1'; wait for 104160 ns;
--        RXD <= '1'; wait for 104160 ns;
--        RXD <= '1'; wait for 104160 ns;
--        RXD <= '1'; wait for 104160 ns;
--        RXD <= '1'; wait for 104160 ns;
--        RXD <= '1'; wait for 104160 ns;
--        RXD <= '1'; wait for 104160 ns;
--        RXD <= '0'; wait for 104160 ns;
--        RXD <= '1'; -- Stop bit
--        wait for 104160 ns;
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
        RXD <= '1'; wait for clk_period;
        RXD <= '1'; wait for clk_period;
        RXD <= '1'; wait for clk_period;
        RXD <= '1'; wait for clk_period;
        RXD <= '1'; wait for clk_period;
        RXD <= '1'; wait for clk_period;
        RXD <= '1'; wait for clk_period;
        RXD <= '0'; wait for clk_period;
        RXD <= '1'; -- Stop bit
        wait for clk_period;
        --Wait for doneRx
        wait until doneRx = '1';
        wait;
    end process;
end behavior;
