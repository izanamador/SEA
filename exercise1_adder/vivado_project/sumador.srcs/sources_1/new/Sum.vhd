----------------------------------------------------------------------------------
-- Company: Universidad de Málaga
-- Engineer: Izan Amador, Jorge L. Benavides
--
-- Create Date: 23.11.2022 17:47:41
-- Design Name: sumador
-- Module Name: sumador - Behavioral
-- Project Name: sumador
-- Target Devices: Zybo 
-- Tool Versions: Vivado 2022.1
-- Description: basic adder block. 
-- 
-- Dependencies: 
-- 
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments:
-- Generic simple adder
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sum is
  generic(
    n : integer := 8);
  port(x : in  std_logic_vector(n-1 downto 0);
       y : in  std_logic_vector(n-1 downto 0);
       s : out std_logic_vector(n-1 downto 0));
end Sum;

architecture Simple of Sum is
begin
  s <= std_logic_vector(unsigned(x) + unsigned(y));
end Simple;
