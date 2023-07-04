----------------------------------------------------------------------------------
-- Company: Universidad de Málaga
-- Engineer: Izan Amador, Jorge L. Benavides
--
-- Create Date: 11.1.2022 
-- Design Name: top
-- Module Name: top
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
  generic(n : integer := 3;
          filter_size  : integer := 32);
  port(jc_in : in std_logic_vector (n-1 downto 0); -- D
       sw    : in std_logic_vector (2 downto 0);   -- Control 
       ce    : in std_logic;
       clk   : in std_logic;
       reset : in std_logic;
       jd_out: out std_logic_vector(n-1 downto 0)); -- q
end top;

architecture Behavioral of top is
  component Sincronizador
    generic (m : integer := 1);  -- tamano del filtro
    Port(
      I     : in  std_logic;
      CKE   : out std_logic;
      reset : in  std_logic;
      clk   : in  std_logic);
  end component Sincronizador;

  component registro
    generic (n: integer := 8);
    port(d: in std_logic_vector(n-1 downto 0);
         control: in std_logic_vector (2 downto 0);
         clk: in std_logic;
         cke: in std_logic;
         reset: in std_logic;
         q: out std_logic_vector(n-1 downto 0));
  end component registro;
  
  signal reset_interno : std_logic := 'U';
  signal ce_interno    : std_logic := 'U';
  
begin
  Sincronizador_reset : Sincronizador generic map(filter_size)
    port map(
      I     => reset,
      CKE   => reset_interno,
      reset => '0',
      clk   => clk
      );
  
  Sincronizador_ce : Sincronizador generic map(filter_size)
    port map(
      I     => ce,
      CKE   => ce_interno,
      reset => '0',
      clk   => clk
      );
  
  FSM : registro generic map(n)
    port map(
      d => jc_in,
      control => sw,
      clk => clk,
      cke => ce_interno,
      reset => reset_interno,
      q => jd_out);
 
end Behavioral;