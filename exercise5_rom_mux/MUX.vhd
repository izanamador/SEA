library ieee;
use ieee.std_logic_1164.all;

use work.Tipos_ROM_MUX.all;

use ieee.numeric_std.all;

entity MUX is
  generic (N_Bits_Dir : Natural := 2);
  port (Direccion : in std_logic_vector (N_Bits_Dir - 1 downto 0);
        Dato      : out std_logic_vector (N_Bits_Dato - 1 downto 0);
        Tabla_ROM : in Tabla(0 to 2**N_Bits_Dir-1));
end MUX;

architecture Comportamiento of Mux is
begin
  Dato <= Tabla_ROM(to_integer(unsigned(Direccion)));

  end Comportamiento;
