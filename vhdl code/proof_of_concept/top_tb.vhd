library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_top is
--  No ports for testbench
end tb_top;

architecture Behavioral of tb_top is

    -- Component under test
    component top
        Port (
            clk, resetn, RXD: in std_logic;
            op: in std_logic_vector(1 downto 0);
            A, B: in std_logic_vector(7 downto 0);
            TXD, done: out std_logic
        );
    end component;

    -- Signals to connect to the DUT
    signal clk       : std_logic := '0';
    signal resetn    : std_logic := '0';
    signal RXD       : std_logic := '1'; -- idle high for UART
    signal op        : std_logic_vector(1 downto 0) := "00";
    signal A, B      : std_logic_vector(7 downto 0) := (others => '0');
    signal TXD       : std_logic;
    signal done      : std_logic;

    constant clk_period : time := 10 ns;

begin

    -- Instantiate DUT
    uut: top
        port map (
            clk => clk,
            resetn => resetn,
            RXD => RXD,
            op => op,
            A => A,
            B => B,
            TXD => TXD,
            done => done
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial reset
        resetn <= '0';
        wait for 50 ns;
        resetn <= '1';

        -- Set operands and operation (e.g., A + B)
        A <= x"0A";
        B <= x"05";
        op <= "00"; -- Adjust based on ALU operation code

        -- Simulate UART RX complete (i.e., top_Rx would raise doneRx)
        wait for 100 ns;
        RXD <= '0'; -- start bit (UART starts with '0')
        wait for clk_period * 10;

        -- simulate byte transfer (not full UART, just triggering doneRx via RXD)
        RXD <= '1'; -- rest of the bits (pretend RX complete)
        wait for clk_period * 80;

        -- Observe results
        wait for 200 ns;

        -- Test another operation (e.g., A - B)
        A <= x"0A";
        B <= x"03";
        op <= "01";

        wait for 100 ns;
        RXD <= '0'; -- trigger another receive
        wait for clk_period * 10;
        RXD <= '1';
        wait for clk_period * 80;

        wait;

    end process;

end Behavioral;
