----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2022 16:49:46
-- Design Name: 
-- Module Name: FF_D - Behavioral
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

entity FF_D is
  generic(T_SU :    Time := 1 ns; T_H : Time := 1 ns; T_W : Time := 1 ns);
  port(D       : in std_logic; q : out std_logic; clk : in std_logic);
end entity FF_D;

architecture Behavioral of FF_D is

begin
-- Logica del flip flop
  process(clk)
  begin
    if clk'event and
      clk = '1'
    then q <= d;
    end if;
  end process;

-- Proceso Pasivo para la verificación del Setup y Hold.
  Comprueba_TSUH : process
  begin
    wait until Rising_Edge(clk);
    assert (D'Stable(T_SU)) report "No cumple el tiempo de Setup!" severity Error;
    wait for T_H;
    assert (D'Stable(T_H)) report "No cumple el tiempo de Hold!" severity Error;
  end process Comprueba_TSUH;

-- Proceso Pasivo para la verificación de la anchura de un pulso (Width).
  Comprueba_TW : process
  begin
    wait until (D'event);  -- D representa la señal a medir (std_Logic).
    assert (D'Delayed'Stable(T_W)) report "No cumple la anchura de pulso!"
      severity Error;
  end process Comprueba_TW;


end Behavioral;
