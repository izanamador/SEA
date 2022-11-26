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

entity MuxV_2a1 is
  generic(
    n : integer := 8);
  port(
    x0  : in  std_logic_vector(n-1 downto 0);
    x1  : in  std_logic_vector(n-1 downto 0);
    sel : in  std_logic;
    y   : out std_logic_vector(n-1 downto 0));
end MuxV_2a1;

architecture Behavioral of MuxV_2a1 is
begin
  process(sel, x0, x1)
  begin
    if sel = '1' then
      y <= x1;
    else
      y <= x0;
    end if;
  end process;
end Behavioral;
