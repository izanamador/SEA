----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2022 17:27:31
-- Design Name: 
-- Module Name: Reg_Des - Behavioral
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

entity Reg_Des is
generic(n: integer := 8);
    port(
        d : in std_logic;
        q : out std_logic_vector (n-1 downto 0);
        reset, des : in std_logic ;
        clk : in std_logic);
end Reg_Des;

architecture Behavioral of Reg_Des is
signal temp : std_logic_vector (n-1 downto 0);
begin
    process(clk, reset)
        begin
            if reset = '1' then
                temp <= (others => '0');
            elsif rising_edge(clk) then
                if des = '1' then
                    for i in temp'high downto 1 loop
                        temp(i) <= temp(i-1);
                    end loop;
                    temp(0) <= d;
                end if;
            end if;
    end process;         
    q <= temp;
end Behavioral;
