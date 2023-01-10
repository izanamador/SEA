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
  signal d_aux: std_logic_vector(n-1 downto 0):= (others => '0');
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
  Secuencial: process (clk, reset, control)
  begin
    if reset = '1' then
      d_aux <= (others => '0');
    elsif rising_edge( clk ) then
      if control = "000" then           -- Carga
        d_aux <= d;
      elsif control = "001" then        -- Cuenta ascendente
        d_aux <= Bitwise_Add(d_aux,number_1);
      elsif control = "010" then        -- Cuenta descendente
        d_aux <= Bitwise_Subs(d_aux,number_1);
      elsif control = "011" then        -- Desplazamiento izquierda
        d_aux <= my_Shift_left(d_aux);
      elsif control = "100" then        -- Desplazamiento derecha
        d_aux <= my_Shift_right(d_aux);
      elsif control = "101" or control = "110" or control = "111" then -- Mantiene
        d_aux <= d_aux;
      end if;
    end if;
  end process;
  
  q <= d_aux;
end behavioral;
