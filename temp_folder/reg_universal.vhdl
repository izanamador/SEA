library ieee;
use ieee.std_logic_1164.all;

entity fsm is
  generic(n:integer);
  port(d: in std_logic_vector(n-1 downto 0);
       control: in std_logic_vector (2 downto 0);
       q: out std_logic_vector(n-1 downto 0);
       clk: in std_logic;
       cke: in std_logic;
       reset: in std_logic);
-- Definir el estado
end entity fsm;

architecture comportamiento of fsm is
begin
  
  end architecture comportamiento;
