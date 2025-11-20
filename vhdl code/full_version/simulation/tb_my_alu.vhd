library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_my_alu is
end tb_my_alu;

architecture behavior of tb_my_alu is

    constant N : integer := 8;

    -- DUT Component
    component my_alu
        generic (N: INTEGER := 8);
        port (
            A, B   : in std_logic_vector(N-1 downto 0);
            op     : in std_logic_vector(1 downto 0);
            DoneRX : in std_logic;
            ET     : out std_logic;
            SWT      : out std_logic_vector(N-1 downto 0)
        );
    end component;

    -- Signals
    signal A_tb, B_tb, SWT_tb : std_logic_vector(N-1 downto 0);
    signal OP_tb            : std_logic_vector(1 downto 0);
    signal DoneRX_tb        : std_logic := '1';
    signal ET_tb            : std_logic;

begin

    -- Instantiate DUT
    DUT: my_alu
        generic map (N => N)
        port map (
            A      => A_tb,
            B      => B_tb,
            op     => OP_tb,
            DoneRX => DoneRX_tb,
            ET     => ET_tb,
            SWT      => SWT_tb
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test 1: A + B (5 + 3 = 8)
        A_tb <= "00000101";
        B_tb <= "00000011";
        OP_tb <= "00";
        wait for 10 ns;

        -- Test 2: A - B (5 - 3 = 2)
        OP_tb <= "01";
        wait for 10 ns;

        -- Test 3: A AND B (11001100 and 10101010 = 10001000)
        A_tb <= "11001100";
        B_tb <= "10101010";
        OP_tb <= "10";
        wait for 10 ns;

        -- Test 4: A OR B (11001100 or 10101010 = 11101110)
        OP_tb <= "11";
        wait for 10 ns;

        -- Stop simulation
        wait;
    end process;

end behavior;