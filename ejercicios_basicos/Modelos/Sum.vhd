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
