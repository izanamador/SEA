----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 26.11.2022 16:14:50
-- Design Name:
-- Module Name: MuxV_2a1 - Behavioral
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

library ieee;
use ieee.std_logic_1164.all;

entity Reg_Des is
  generic(n : integer := 8);
  port(
    d          : in  std_logic;
    q          : out std_logic_vector(n-1 downto 0);
    reset, des : in  std_logic;
    clk        : in  std_logic);
end Reg_Des;

architecture A of Reg_Des is
  signal temp : std_logic_vector(n-1 downto 0);
begin
  process(clk, reset)
  begin
    if reset = '1' then
      temp <= (others => '0');
    elsif rising_edge(clk) then
      if des = '1' then
        for i in temp'high downto 1 loop
          -- 'high Atributo para detectar el indice mayor de un array
          temp(i) <= temp(i-1);
        end loop;
        temp(0) <= d;
      end if;
    end if;
  end process;
  q <= temp;
end A;
