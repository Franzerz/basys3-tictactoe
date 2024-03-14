----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.02.2024 18:18:02
-- Design Name: 
-- Module Name: sseg_decoder - Behavioral
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

entity sseg_decoder is
    Port ( bin : in STD_LOGIC_VECTOR (3 downto 0);
           sseg_sel : in STD_LOGIC_VECTOR (3 downto 0);
           sseg : out STD_LOGIC_VECTOR (6 downto 0);
           sseg_en : out STD_LOGIC_VECTOR (3 downto 0));
end sseg_decoder;

architecture Behavioral of sseg_decoder is

begin

    sseg_en <= sseg_sel;
    
    sseg_display : process (bin)
    
    begin
        case bin is
            when "0000" => sseg <= "0000001"; -- "0"
            when "0001" => sseg <= "1001111"; -- "1"
            when "0010" => sseg <= "0010010"; -- "2"
            when "0011" => sseg <= "0000110"; -- "3"
            when "0100" => sseg <= "1001100"; -- "4"
            when "0101" => sseg <= "0100100"; -- "5"
            when "0110" => sseg <= "0100000"; -- "6"
            when "0111" => sseg <= "0001111"; -- "7"
            when "1000" => sseg <= "0000000"; -- "8"
            when "1001" => sseg <= "0000100"; -- "9"
            when "1010" => sseg <= "0000010"; -- A
            when "1011" => sseg <= "1100000"; -- B
            when "1100" => sseg <= "0110001"; -- C
            when "1101" => sseg <= "1000010"; -- D
            when "1110" => sseg <= "0110000"; -- E
            when "1111" => sseg <= "0111000"; -- F
         end case;
     end process sseg_display;


end Behavioral;
