----------------------------------------------------------------------------------
-- Company: Universidad de Malaga
-- Engineer: Izan Amador, Jorge L. Benavides
--
-- Create Date: 23.11.2022 17:47:41
-- Design Name: MuxV_2a1
-- Module Name: MuxV_2a1 - Behavioral
-- Project Name: multiplexor2a1
-- Target Devices: Zybo
-- Tool Versions: Vivado 2022.1
-- Description: A basic multiplexer 2 inputs.
--
-- Dependencies:
--
-- Revision:
-- Revision 0.02 - File revised
-- Additional Comments:
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
