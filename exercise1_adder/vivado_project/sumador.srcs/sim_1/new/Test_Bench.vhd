----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 23.11.2022 16:50:19
-- Design Name:
-- Module Name: Test_Bench - Behavioral
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
use ieee.numeric_std.all;

entity Test_Bench is
--  Port ( );
end Test_Bench;

architecture Behavioral of Test_Bench is

  component Sum
    generic(
      n : integer := 8);
    port(x : in  std_logic_vector(n-1 downto 0);
         y : in  std_logic_vector(n-1 downto 0);
         s : out std_logic_vector(n-1 downto 0));
  end Component Sum;

  constant n : integer := 3;
  signal x_interno, y_interno, s_interno : std_logic_vector(n-1 downto 0) := (others => 'U');

begin

  DUT : Sum
    generic map (n)
    port map(
      x  => x_interno,
      y  => y_interno,
      s  => s_interno);

  test: process
  begin
    for item in 0 to 2**n-1 loop

      x_interno <= std_logic_vector(to_unsigned(item,n));

      for item2 in 0 to 2**n-1 loop

        y_interno <= std_logic_vector(to_unsigned(item2,n));
        wait for 5 ns;

      end loop;

    end loop;

  end process;
end Behavioral;
