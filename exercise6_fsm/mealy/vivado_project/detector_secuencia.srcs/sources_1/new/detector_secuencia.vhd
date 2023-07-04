----------------------------------------------------------------------------------
-- Company: Universidad de Málaga
-- Engineer: Izan Amador, Jorge L. Benavides
--
-- Create Date: 7.12.2022 15:13
-- Design Name: detector_secuencia
-- Module Name: detector_secuencia - Behavioral
-- Project Name: detector_secuencia
-- Target Devices: Zybo 
-- Tool Versions: Vivado 2022.1
-- Description: Debouncer for a button. 
-- 
-- Dependencies: 
-- 
-- Revision: 
-- Revision 0.01 - Test Bench working
-- Additional Comments:
-- FSM Mealy Design
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity detector_secuencia is

  port(x     : in  std_logic;
    clk   : in  std_logic;
    reset : in  std_logic;
    cke   : in  std_logic;
    y     : out std_logic);
  type Estado is (A, B, C, D, E, F);

end detector_secuencia;

architecture Behavioral of detector_secuencia is

  signal Estado_Actual  : Estado := A;
  signal Proximo_Estado : Estado;

begin
  Combinacional : process(x, Estado_Actual)
  begin
    case Estado_Actual is
--------------------------------------------------
      when A =>
        -- Ecuacion de Transicion de Estado A:
        if x = '1' then
          Proximo_Estado <= B;
          -- Ecuacion de salida A:
          y <= '0';
        else
          Proximo_Estado <= A;
          y <= '0';
        end if;
--------------------------------------------------
      when B =>
        -- Ecuacion de Transicion de Estado B:
        if x = '0' then
          Proximo_Estado <= C;
          -- Ecuacion de salida B:
          y <= '0';
        else
          Proximo_Estado <= A;
          y <= '0';
        end if;
--------------------------------------------------
      when C =>
        -- Ecuacion de Transicion de Estado C:
        if x = '1' then
          Proximo_Estado <= D;
          -- Ecuacion de salida C:
          y <= '0';
        else
          Proximo_Estado <= A;
          -- Ecuacion de salida C:
          y <= '0';
        end if;
--------------------------------------------------
      when D =>
        -- Ecuacion de Transicion de Estado:
        if x = '0' then
          Proximo_Estado <= E;
          -- Ecuacion de salida:
          y <= '0';
        else
          Proximo_Estado <= B;
          -- Ecuacion de salida:
          y <= '0';
        end if;
--------------------------------------------------
      when E =>
-- Ecuacion de Transicion de Estado:
        if x = '0' then
          Proximo_Estado <= F;
          -- Ecuacion de salida:
          y <= '0';
        else
          Proximo_Estado <= B;
          -- Ecuacion de salida:
          y <= '0';
        end if;
--------------------------------------------------
      when F =>
        -- Ecuacion de Transicion de Estado:
        if x = '1' then
          Proximo_Estado <= B;
          -- Ecuacion de salida:
          y <= '1'; -- La secuencia es correcta '101001'
        else
          Proximo_Estado <= A;
          -- Ecuacion de salida:
          y <= '0';
        end if;
    end case;
  end process Combinacional;

  Secuencial : process(clk, reset, cke)
  begin
    if reset = '1' then
      Estado_Actual <= A;
    elsif rising_edge(clk) then
      if cke = '1' then
        Estado_Actual <= Proximo_Estado;
        end if;
    end if;
  end process Secuencial;
end Behavioral;
