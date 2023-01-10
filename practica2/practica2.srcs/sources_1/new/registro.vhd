----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.01.2023 20:56:31
-- Design Name: 
-- Module Name: registro - Behavioral
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

-- registro universal de n bits genérico y esquema fsm
-- entidad del registro universal
entity registro is
  generic (n: integer := 8);
  port(d: in std_logic_vector(n-1 downto 0);
       control: in std_logic_vector (2 downto 0);
       clk: in std_logic;
       cke: in std_logic;
       reset: in std_logic;
       q: out std_logic_vector(n-1 downto 0));
  
  type estado is (s_carga, s_cuenta_arriba, s_cuenta_abajo, s_desp_izq,   s_desp_der, s_guarda_dato);
end entity;


-- arquitectura del registro universal
architecture behavioral of registro is

  signal Estado_Actual  : estado := s_carga;
  signal Proximo_Estado : estado;
  signal number_1: std_logic_vector(n-1 downto 0) := (0 => '1', others => '0');
  
  function Bitwise_Add(numA, numB :std_logic_vector) return std_logic_vector is
    variable sum: std_logic_vector(n-1 downto 0):= (others=> '0');
    variable carry: std_logic_vector(n-1 downto 0):= (others=> '0');
    variable internal_0: std_logic_vector(n-1 downto 0):= (others=> '0');
  begin
    if numB = internal_0  then
      return numA;
    else
      sum := numA xor numB;
      carry := (numA and numB);
      carry(n-1 downto 1) := carry(n-2 downto 0);
      carry(0) := '0';
      return Bitwise_Add(sum,carry);
    end if;
  end function;

  function Bitwise_Subs(numA, numB:std_logic_vector) return std_logic_vector is
        variable subs: std_logic_vector(n-1 downto 0):= (others=> '0');
        variable carry2: std_logic_vector(n-1 downto 0):= (others=> '0');
        variable internal_0: std_logic_vector(n-1 downto 0):= (others=> '0');
  begin
    if numB = internal_0  then
      return numA;
    else
      subs := numA xor numB;
      carry2 := ((not numA) and numB);
      carry2(n-1 downto 1) := carry2(n-2 downto 0);
      carry2(0) := '0';
      return Bitwise_Subs(subs,carry2);
    end if;
  end function;

  function my_Shift_left(numA: std_logic_vector) return std_logic_vector is
    variable result: std_logic_vector(n-1 downto 0):= (others=> '0');
  begin
    result:= numA;
    result(n-1 downto 1) := result(n-2 downto 0);
    result(0) := '0';
      return result;
  end function;

  function my_Shift_right(numA: std_logic_vector) return std_logic_vector is
    variable result: std_logic_vector(n-1 downto 0):= (others=> '0');
  begin
    result:= numA;
    result(n-2 downto 0) := result(n-1 downto 1);
    result(n-1) := '0';
      return result;
  end function;

  
begin
  Combinacional: process(control,Estado_Actual)
    variable d_aux: std_logic_vector(n-1 downto 0);
  begin
    case Estado_Actual is
--------------------------------------------------
      when s_carga =>
-- Ecuación de salida s_carga:
-- Carga datos
        d_aux := d;
        q <= d;
-- Ecuación de Transición de Estado s_carga:
        if control = "001" then
          Proximo_Estado <= s_cuenta_arriba;
        else
          Proximo_Estado <= s_carga;
        end if;
        
--------------------------------------------------
      when s_cuenta_arriba =>
-- Ecuación de salida s_cuenta_arriba:
-- Cuenta hacia arriba
        d_aux := Bitwise_Add(d_aux,number_1);
        q <= d_aux;
-- Ecuación de Transición de Estado s_carga:
        if control = "010" then
          Proximo_Estado <= s_cuenta_abajo;
        else
          Proximo_Estado <= s_cuenta_arriba;
        end if;
        
--------------------------------------------------
      when s_cuenta_abajo =>
-- Ecuación de salida s_carga:
        d_aux := Bitwise_Subs(d_aux,number_1);
        q <= d_aux;
-- Ecuación de Transición de Estado s_carga:
        if control = "011" then
          Proximo_Estado <= s_desp_izq;
        else
          Proximo_Estado <= s_cuenta_abajo;
        end if;

--------------------------------------------------
      when s_desp_izq =>
-- Ecuación de salida s_carga:
        d_aux := my_Shift_left(d_aux);
        q <= d_aux;
-- Ecuación de Transición de Estado s_carga:
        if control = "100" then
          Proximo_Estado <= s_desp_der;
        else
          Proximo_Estado <= s_desp_izq;
        end if;
        
--------------------------------------------------
      when s_desp_der =>
-- Ecuación de salida s_carga:
        d_aux := my_Shift_right(d_aux);
        q <= d_aux;        
-- Ecuación de Transición de Estado s_carga:
        if control = "101" or control = "110" or control = "111" then
          Proximo_Estado <= s_guarda_dato;
        else
          Proximo_Estado <= s_desp_der;
        end if;
        
--------------------------------------------------
      when s_guarda_dato =>
-- Ecuación de salida:
        q <= d_aux;
-- Ecuación de Transición de Estado:
        if control = "000" then
          Proximo_Estado <= s_carga;
        else
          Proximo_Estado <= s_guarda_dato;
        end if;
    end case;
  end process;
  
  Secuencial : process(clk, reset, cke)
  begin
    if reset = '1' then
      Estado_Actual <= s_carga;
    elsif rising_edge(clk) then
      if cke = '1' then
        Estado_Actual <= Proximo_Estado;
      end if;
    end if;
  end process Secuencial;
  
end behavioral;
