library ieee;
use ieee.std_logic_1164.all;

entity detector_secuencia is
  generic(k : integer := 1;
          p : integer := 1);
  port(x      : in  std_logic_vector(k-1 downto 0);  -- k Entradas.
       y     : out std_logic_vector(p-1 downto 0);  -- p Salidas.
       reset : in  std_logic;
       clk   : in  std_logic);

  type Estado is (A, B, C, D, E);       -- m Estados.

end entity detector_secuencia;


architecture FSM_MOORE of detector_secuencia is

  signal Estado_Actual  : Estado := A;
  signal Proximo_Estado : Estado;

begin

  Combinacional : process(x, Estado_Actual)
    variable x_interno_true : std_logic_vector(k-1 downto 0) := (others => '1');
  begin
    case Estado_Actual is

--------------------------------------------------
      when A =>
-- Ecuación de salida A:
        y <= (others => '0');
-- Ecuación de Transición de Estado A:
        if x = x_interno_true then
          Proximo_Estado <= B;
        else
          Proximo_Estado <= A;
        end if;

--------------------------------------------------
      when B =>
-- Ecuación de salida B:
        y <= (others => '0');
-- Ecuación de Transición de Estado B:
        if x = x_interno_true then
          Proximo_Estado <= C;
        else
          Proximo_Estado <= A;
        end if;

--------------------------------------------------
      when C =>
-- Ecuación de salida C:
        y <= (others => '0');
-- Ecuación de Transición de Estado C:
        if x = x_interno_true then
          Proximo_Estado <= C;
        else
          Proximo_Estado <= D;
        end if;

--------------------------------------------------
      when D =>
-- Ecuación de salida:
        y <= (others => '0');
-- Ecuación de Transición de Estado:
        if x = x_interno_true then
          Proximo_Estado <= E;
        else
          Proximo_Estado <= A;
        end if;

--------------------------------------------------
      when E =>
-- Ecuación de salida:
        y <= (others => '0');
-- Ecuación de Transición de Estado:
        if x = x_interno_true then
          Proximo_Estado <= C;
        else
          Proximo_Estado <= A;
        end if;
    end case;
  end process Combinacional;

  Secuencial : process(clk, reset)
  begin
    if reset = '1' then
      Estado_Actual <= A;
    elsif rising_edge(clk) then
      Estado_Actual <= Proximo_Estado;
    end if;
  end process Secuencial;

end FSM_MOORE;
