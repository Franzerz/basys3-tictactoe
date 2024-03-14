library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TicTacToe is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        left : in STD_LOGIC_VECTOR (0 downto 0) := (others => '0');
        up : in STD_LOGIC_VECTOR (0 downto 0) := (others => '0');
        right : in STD_LOGIC_VECTOR (0 downto 0) := (others => '0');
        down : in STD_LOGIC_VECTOR (0 downto 0) := (others => '0');
        confirm : in STD_LOGIC_VECTOR (0 downto 0) := (others => '0');
        led : out STD_LOGIC_VECTOR (7 downto 0);
        seven_seg : out STD_LOGIC_VECTOR (7 downto 0)
    );
end TicTacToe;

architecture Behavioral of TicTacToe is
    signal current_state : STD_LOGIC_VECTOR (2 downto 0) := "000";
    signal next_state : STD_LOGIC_VECTOR (2 downto 0);
    signal score : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    type state_type is (start, player1_turn, player2_turn, check_win, game_over, game_tie);
    signal state : state_type;
    signal current_player : std_logic := '0';
    signal player1 : std_logic := '1';
    signal player2 : std_logic := '0';
    signal winner_exists : boolean := false;
    signal move_counter : integer range 0 to 9 := 0;
    signal row : integer range 0 to 7 := 0;
    type board_type is array (0 to 2, 0 to 2) of std_logic;
    signal board : board_type := (others => (others => '0'));
    type led_matrix_type is array (0 to 7, 0 to 7) of std_logic;
    signal led_matrix : led_matrix_type := (others => (others => '0'));
    signal cursor_x : integer range 0 to 2 := 0;
    signal cursor_y : integer range 0 to 2 := 0;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            state <= start;
            seven_seg <= "00000000"; -- Clear the seven segment display
            board <= (others => (others => '0'));
            led_matrix <= (others => (others => '0'));
            row <= 0;
            move_counter <= 0;
        elsif rising_edge(clk) then
            case state is
                when start =>
                    -- Initialize the game board
                    state <= player1_turn;

                when player1_turn =>
                    -- Wait for player 1 to make a move
                    -- Update the game board
                    if confirm = '1' then
                        if board(cursor_x, cursor_y) = '0' then
                            board(cursor_x, cursor_y) <= player1;
                            move_counter <= move_counter + 1;
                            state <= check_win;
                        end if;
                    end if;

                when player2_turn =>
                    -- Wait for player 2 to make a move
                    -- Update the game board
                    if confirm = '1' then
                        if board(cursor_x, cursor_y) = '0' then
                            board(cursor_x, cursor_y) <= player2;
                            move_counter <= move_counter + 1;
                            state <= check_win;
                        end if;
                    end if;

                when check_win =>
                    -- Check if there's a winner
                    if winner_exists then
                        state <= game_over;
                    elsif move_counter = 9 then
                        state <= game_tie;
                    else
                        if current_player = player1 then
                            state <= player2_turn;
                        else
                            state <= player1_turn;
                        end if;
                    end if;

                when game_over =>
                    -- Display the winner on the seven segment display
                    if current_player = player1 then
                        seven_seg <= "00000001"; -- Display 1 for player 1
                    else
                        seven_seg <= "00000010"; -- Display 2 for player 2
                    end if;

                    -- Wait for reset signal to start a new game
                    if reset = '1' then
                        state <= start;
                        seven_seg <= "00000000"; -- Clear the seven segment display
                    end if;

                when game_tie =>
                    -- Display tie on the seven segment display
                    seven_seg <= "00000011"; -- Display 3 for tie

                    -- Wait for reset signal to start a new game
                    if reset = '1' then
                        state <= start;
                        seven_seg <= "00000000"; -- Clear the seven segment display
                    end if;

                when others =>
                    -- Other states
            end case;

            -- Map the game board to the LED matrix
            for i in 0 to 2 loop
                for j in 0 to 2 loop
                    led_matrix(3*i+1, 3*j+1) <= board(i, j);
                end loop;
            end loop;

            -- Multiplexing
            led <= led_matrix(row);
            row <= row + 1;
            if row = 8 then
                row <= 0;
            end if;
        end if;
    end process;
end Behavioral;