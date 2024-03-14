library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TicTacToe_tb is
end TicTacToe_tb;

architecture Behavioral of TicTacToe_tb is
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal left : STD_LOGIC_VECTOR (0 to 0);
    signal up : STD_LOGIC_VECTOR (0 to 0);
    signal right : STD_LOGIC_VECTOR (0 to 0);
    signal down : STD_LOGIC_VECTOR (0 to 0);
    signal confirm : STD_LOGIC_VECTOR (0 to 0);
    signal seg : STD_LOGIC_VECTOR (6 downto 0);

    component TicTacToe is
        Port (
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            left : in STD_LOGIC_VECTOR (0 to 0);
            up : in STD_LOGIC_VECTOR (0 to 0);
            right : in STD_LOGIC_VECTOR (0 to 0);
            down : in STD_LOGIC_VECTOR (0 to 0);
            confirm : in STD_LOGIC_VECTOR (0 to 0);
            seg : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

begin
    uut: TicTacToe
        port map (
            clk => clk,
            reset => reset,
            left => left,
            up => up,
            right => right,
            down => down,
            confirm => confirm,
            seg => seg
        );

    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    stimulus_process : process
    begin
        -- Initialize the inputs
        reset <= '1';
        left <= (others => '0');
        up <= (others => '0');
        right <= (others => '0');
        down <= (others => '0');
        confirm <= (others => '0');
        wait for 20 ns;

        -- Reset the game
        reset <= '0';
        wait for 20 ns;

        -- Simulate button presses and check the outputs
        -- ...

        wait;
    end process;
end Behavioral;