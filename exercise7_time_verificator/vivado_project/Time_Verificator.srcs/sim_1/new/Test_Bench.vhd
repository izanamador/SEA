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

  component FF_D
    generic(T_SU :    Time := 1 ns; T_H : Time := 1 ns; T_W : Time := 1 ns);
    port(D       : in std_logic; q : out std_logic; clk : in std_logic);
  end Component FF_D;

  signal D_interno, q_interno : STD_LOGIC := 'U';
  signal clk_interno          : STD_LOGIC := '0';
  constant semiperiodo        : time      := 10 ns;

begin

  DUT : FF_D
    generic map (
      T_SU => 1 ns, -- tiempo de setup
      T_H  => 1 ns, -- tiempo de hold
      T_W  => 1 ns) -- ancho del pulso
    port map(
      D   => D_interno,
      q   => q_interno,
      clk => clk_interno);

  clock_gen : process (clk_interno) is
  begin
    if clk_interno = '0' then
      clk_interno <= '1' after semiperiodo,
                     '0' after 2*semiperiodo;
    end if;
  end process clock_gen;

  Data : process
  begin
    -- Pulso correcto
    D_interno <= '0';
    wait for 9 ns;
    D_interno <= '1';
    wait for 2 ns;
    D_interno <= '0';

    wait for 18.5 ns;

    -- Pulso incorrecto
    D_interno <= '1';
    wait for 0.5 ns;
    D_interno <= '0';
    wait;
    end process;
end Behavioral;
