----------------------------------------------------------------------------------
-- Company: Universidad de Málaga
-- Engineer: Izan Amador, Jorge L. Benavides
--
-- Create Date: 23.11.2022 17:47:41
-- Design Name: registro_desplazamiento
-- Module Name: reg_des - Behavioral
-- Project Name: registro_desplazamiento
-- Target Devices: Zybo 
-- Tool Versions: Vivado 2022.1
-- Description: basic adder block. 
-- 
-- Dependencies: 
-- 
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments:
-- Basic shift register
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
