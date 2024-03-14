library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ScoreDisplay is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        score : in INTEGER range 0 to 9;
        seg : out STD_LOGIC_VECTOR (6 downto 0)
    );
end ScoreDisplay;

architecture Behavioral of ScoreDisplay is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            seg <= "1000000"; -- Display 0
        elsif rising_edge(clk) then
            case score is
                when 0 => seg <= "1000000"; -- Display 0
                when 1 => seg <= "1111001"; -- Display 1
                when 2 => seg <= "0100100"; -- Display 2
                when 3 => seg <= "0110000"; -- Display 3
                when 4 => seg <= "0011001"; -- Display 4
                when 5 => seg <= "0010010"; -- Display 5
                when 6 => seg <= "0000010"; -- Display 6
                when 7 => seg <= "1111000"; -- Display 7
                when 8 => seg <= "0000000"; -- Display 8
                when 9 => seg <= "0010000"; -- Display 9
                when others => seg <= "1111111"; -- Display nothing
            end case;
        end if;
    end process;
end Behavioral;