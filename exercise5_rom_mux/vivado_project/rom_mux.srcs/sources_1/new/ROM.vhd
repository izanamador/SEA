library ieee;
use ieee.std_logic_1164.all;

use work.Tipos_ROM_MUX.all;

use ieee.numeric_std.all;

entity ROM is
  generic (N_Bits_Dir : Natural := 2);
  port (Direccion : in std_logic_vector (N_Bits_Dir - 1 downto 0);
        Dato      : out std_logic_vector (N_Bits_Dato - 1 downto 0));
end ROM;

architecture Comportamiento of ROM is
  -- Se rellena la ROM con varios estilos:
  constant Tabla_ROM : Tabla(0 to 2**N_Bits_Dir-1) :=
    (('1','0','1','0','1','0','1','0'),
     b"1011_1011", -- si no se indica la "b" no sería correcto
     --x"CC",
     --x"DD",
     --x"EE",
     --x"FF",
     (others => '0'),
     (0 | 4 => '1', others => '0'));
begin
  Dato <= Tabla_ROM(to_integer(unsigned(Direccion)));

  end Comportamiento;
