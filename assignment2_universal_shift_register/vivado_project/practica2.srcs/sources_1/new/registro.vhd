----------------------------------------------------------------------------------
-- Company: Universidad de Málaga
-- Engineer: Izan Amador, Jorge L. Benavides
--
-- Create Date: 11.1.2022 
-- Design Name: registro
-- Module Name: registro
-- Project Name: practica2
-- Target Devices: Zybo 
-- Tool Versions: Vivado 2022.1
-- Description: Universal register with several operations without numeric library.
-- 
-- Dependencies: 
-- 
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments:
-- Sincronizers implemented in buttons
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity registro is
  generic (n: integer := 8);
  port(d: in std_logic_vector(n-1 downto 0);
       control: in std_logic_vector (2 downto 0);
       clk: in std_logic;
       cke: in std_logic;
       reset: in std_logic;
       q: out std_logic_vector(n-1 downto 0));
  
end entity;

architecture behavioral of registro is
  signal d_aux: std_logic_vector(n-1 downto 0):= (others => '0');
  signal number_1: std_logic_vector(n-1 downto 0) := (0 => '1', others => '0');
--------------------------FUNCIONES-------------------------------------------------
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
  
  function Bitwise_Add(numA, numB :std_logic_vector) return std_logic_vector is
    variable carry: std_logic_vector(n-1 downto 0):= (others=> '0');
    variable internal_0: std_logic_vector(n-1 downto 0):= (others=> '0');
    variable internal_numA: std_logic_vector(n-1 downto 0):= (others=> '0');
    variable internal_numB: std_logic_vector(n-1 downto 0):= (others=> '0');
    
  begin
    internal_numA := numA;
    internal_numB := numB;
    for i in n-1 downto 0 loop
      carry := internal_numA and internal_numB;
      internal_numA := internal_numA xor internal_numB;
      internal_numB := my_Shift_left(carry);      
    end loop;
    return internal_numA;
  end function;

  function Bitwise_Subs(numA, numB:std_logic_vector) return std_logic_vector is
    variable borrow: std_logic_vector(n-1 downto 0):= (others=> '0');
    variable internal_0: std_logic_vector(n-1 downto 0):= (others=> '0');
    variable internal_numA: std_logic_vector(n-1 downto 0):= (others=> '0');
    variable internal_numB: std_logic_vector(n-1 downto 0):= (others=> '0');
  begin
    internal_numA := numA;
    internal_numB := numB;
    
    for i in n-1 downto 0 loop
      borrow := ((not internal_numA) and internal_numB);
      internal_numA := internal_numA xor internal_numB;
      internal_numB := my_Shift_left(borrow);
    end loop;
    return internal_numA;
  end function;
--------------------------------------------------------------------------------
begin
  Secuencial: process (clk, reset, control)
  begin
    if reset = '1' then
      d_aux <= (others => '0');
    elsif rising_edge( clk ) and cke = '1' then
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
