----------------------------------------------------------------------------------
-- Company: Universidad de Málaga
-- Engineer: Izan Amador, Jorge L. Benavides
--
-- Create Date: 23.11.2022 17:47:41
-- Design Name: Debouncer
-- Module Name: Sincronizador - Behavioral
-- Project Name: Sincronizador
-- Target Devices: Zybo 
-- Tool Versions: Vivado 2022.1
-- Description: Debouncer for a button. 
-- 
-- Dependencies: 
-- 
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments:
-- Generic size filter m
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sincronizador is
  Port(
    I     : in  std_logic;
    CKE   : out std_logic;
    reset : in  std_logic;
    clk   : in  std_logic);
end Sincronizador;

architecture Behavioral of Sincronizador is
  signal s : std_logic;
  component Antirrebotes is
  generic(m : integer);
    port(I     :     std_logic;
         O     : out std_logic;
         reset : in  std_logic;
         clk   : in  std_logic);
  end component;
  component CKE_Gen is
    port(I     : in  std_logic;
         O     : out std_logic;
         reset : in  std_logic;
         clk   : in  std_logic);
  end component;
begin
  DB    : Antirrebotes 
            generic map (32) -- Size of the filter
            port map (
                   I => I, 
                   O => s, 
                   reset => reset, 
                   clk => clk);
  CKGEN : CKE_Gen 
            port map (
                   I => I,
                   O => CKE, 
                   reset => reset, 
                   clk => clk);
end Behavioral;