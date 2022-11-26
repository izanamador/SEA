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

entity Contador_Asc is
  generic(n : integer := 8);
  port(din              : in  std_logic_vector(n-1 downto 0);
        dout            : out std_logic_vector(n-1 downto 0);
        reset, ce, load : in  std_logic;
        fdc             : out std_logic;
        clk             : in  std_logic);
end Contador_Asc;

architecture A of Contador_Asc is
  signal cuenta : unsigned(n-1 downto 0);
begin
  process (clk, reset)
  begin
    if reset = '1' then
      cuenta <= (others => '0');
    elsif rising_edge(clk) then
      if load = '1' then
        cuenta <= unsigned(din);
      elsif ce = '1' then
        cuenta <= cuenta + 1;
      end if;
    end if;
  end process;
  dout <= std_logic_vector(cuenta);
  fdc  <= '1' when (to_integer(cuenta) = 2**n-1) else '0';
end A;
