----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2019 15:04:43
-- Design Name: 
-- Module Name: Sincronizador - Estructura
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sincronizador is
    generic ( n     : natural := 4 );
    Port    ( I     : in STD_LOGIC;
              CKE   : out STD_LOGIC;
              reset : in STD_LOGIC;
              clk   : in STD_LOGIC);
end Sincronizador;

architecture Estructura of Sincronizador is

signal    s1, s2 : STD_LOGIC;        -- Señales internas de la estructura.

component Debouncer is generic ( n     : natural := 4 );
                       port    ( I     : in std_logic;
                                 O     : out std_logic;
                                 reset : in std_logic;
                                 clk   : in std_logic);
end component Debouncer;
component CKE_Gen is port( I : in std_logic; O : out std_logic; reset: in std_logic; clk: in std_logic);
end component CKE_Gen;

begin
DB:     Debouncer generic map( n )  
                  port    map (I=>I, O=>s2, reset=>reset,clk=>clk);
CKGEN:  CKE_Gen   port    map (I=>s2,O=>CKE,reset=>reset,clk=>clk);
end Estructura;
