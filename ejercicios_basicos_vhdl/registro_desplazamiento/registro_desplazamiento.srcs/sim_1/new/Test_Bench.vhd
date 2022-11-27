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

  component Reg_Des
    generic(n : integer := 8);
    port(
      d          : in  std_logic;
      q          : out std_logic_vector(n-1 downto 0);
      reset, des : in  std_logic;
      clk        : in  std_logic);
  end Component Reg_Des;

  constant n : integer := 3;
  constant semiperiodo : time := 10 ns;
  signal d_interno, des_interno, reset_interno: std_logic := 'U';
  signal q_interno : std_logic_vector(n-1 downto 0) := (others => 'U');
  signal clk_interno : std_logic := '0';

begin

  DUT : Reg_Des
    generic map (n)
    port map(
      d  => d_interno,
      q  => q_interno,
      reset  => reset_interno,
      des => des_interno,
      clk => clk_interno);

-- Taken from The Student Guide to VHDL, Peter J.Asheden
  clock_gen: process (clk_interno) is
  begin
    if clk_interno = '0' then
      clk_interno <= '1' after semiperiodo,
                     '0' after 2*semiperiodo;
    end if;
  end process clock_gen;

  des_interno <= '1';

  test: process
  begin
    d_interno <= '1' after 5 ns, '0' after 10 ns;

  end process;
end Behavioral;
