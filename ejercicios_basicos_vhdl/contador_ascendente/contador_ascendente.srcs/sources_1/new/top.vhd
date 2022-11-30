----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2022 11:39:30
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
  generic(counter_size : integer := 4;    -- tamano del contador
          filter_size  : integer := 32);  -- tamano del filtro
  port(jc_in  : in  std_logic_vector (counter_size-1 downto 0);
       reset  : in  std_logic;
       ce     : in  std_logic;
       load   : in  std_logic;
       clk    : in  std_logic;
       jd_out : out std_logic_vector (counter_size-1 downto 0);
       fdc    : out std_logic
       );
end entity top;

architecture Behavioral of top is

  component Sincronizador
    generic (m : integer := 1);         -- tamano del filtro
    Port(
      I     : in  std_logic;
      CKE   : out std_logic;
      reset : in  std_logic;
      clk   : in  std_logic);
  end component Sincronizador;

  component Contador_Asc
    generic(n : integer := 8);
    port(din             : in  std_logic_vector(n-1 downto 0);
         dout            : out std_logic_vector(n-1 downto 0);
         reset, ce, load : in  std_logic;
         fdc             : out std_logic;
         clk             : in  std_logic);
  end component Contador_Asc;

  signal reset_interno : std_logic := 'U';
  signal ce_interno    : std_logic := 'U';
  signal load_interno  : std_logic := 'U';

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
  Sincronizador_load : Sincronizador generic map(filter_size)
    port map(
      I     => load,
      CKE   => load_interno,
      reset => '0',
      clk   => clk
      );

  Contador : Contador_Asc generic map(counter_size)
    port map(
      din  => jc_in,
      reset => reset_interno,
      ce => ce_interno,
      load => load_interno,
      clk  => clk,
      dout => jd_out,
      fdc =>  fdc
      );

end Behavioral;
