----------------------------------------------------------------------------------
-- Company: Universidad de Málaga
-- Engineer: Izan Amador, Jorge L. Benavides
--
-- Create Date: 23.11.2022 17:47:41
-- Design Name: Debouncer
-- Module Name: Reg_Des - Behavioral
-- Project Name: Sincronizador
-- Target Devices: Zybo 
-- Tool Versions: Vivado 2022.1
-- Description: Generic shift register
-- 
-- Dependencies: 
-- 
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments:
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
