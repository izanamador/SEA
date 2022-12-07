----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.12.2022 11:39:15
-- Design Name: 
-- Module Name: detector_secuencia - Behavioral
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

entity detector_secuencia is

  port(
    x     : in  std_logic;
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
        -- Ecuación de Transición de Estado A:
        if x = '1' then
          Proximo_Estado <= B;
          -- Ecuación de salida A:
          y <= '0';
        else
          Proximo_Estado <= A;
          y <= '0';
        end if;

--------------------------------------------------
      when B =>
        -- Ecuación de Transición de Estado B:
        if x = '0' then
          Proximo_Estado <= C;
          -- Ecuación de salida B:
          y <= '0';
        else
          Proximo_Estado <= A;
          y <= '0';
        end if;

--------------------------------------------------
      when C =>
        -- Ecuación de Transición de Estado C:
        if x = '1' then
          Proximo_Estado <= D;
          -- Ecuación de salida C:
          y <= '0';
        else
          Proximo_Estado <= A;
          -- Ecuación de salida C:
          y <= '0';
        end if;

--------------------------------------------------
      when D =>
        -- Ecuación de Transición de Estado:
        if x = '0' then
          Proximo_Estado <= E;
          -- Ecuación de salida:
          y <= '0';
        else
          Proximo_Estado <= B;
          -- Ecuación de salida:
          y <= '0';
        end if;

--------------------------------------------------
      when E =>
-- Ecuación de Transición de Estado:
        if x = '0' then
          Proximo_Estado <= F;
          -- Ecuación de salida:
          y <= '0';
        else
          Proximo_Estado <= B;
          -- Ecuación de salida:
          y <= '0';
        end if;

      when F =>
        -- Ecuación de Transición de Estado:
        if x = '1' then
          Proximo_Estado <= B;
          -- Ecuación de salida:
          y <= '1';
        else
          Proximo_Estado <= A;
          -- Ecuación de salida:
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
