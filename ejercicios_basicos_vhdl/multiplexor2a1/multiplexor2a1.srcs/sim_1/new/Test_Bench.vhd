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

entity Test_Bench is
--  Port ( );
end Test_Bench;

architecture Behavioral of Test_Bench is

  component MuxV_2a1
    generic(
      n : integer := 8);
    port(
      x0  : in  std_logic_vector(n-1 downto 0);
      x1  : in  std_logic_vector(n-1 downto 0);
      sel : in  std_logic;
      y   : out std_logic_vector(n-1 downto 0));
  end Component MuxV_2a1;

  constant n           : integer := 2;

  signal x0_interno, x1_interno, y_interno : std_logic_vector(n-1 downto 0) := (others => 'U');
  signal sel_interno                       : std_logic                      := 'U';

begin

  DUT : MuxV_2a1
    generic map (n)
    port map(
      x0  => x0_interno,
      x1  => x1_interno,
      sel => sel_interno,
      y   => y_interno);

  test: process
  begin
    x0_interno <= "01";
    x1_interno <= "10";
    wait for 10 ns;
    sel_interno <= '0';
    wait for 10 ns;
    sel_interno <= '1';
    end process;
end Behavioral;
