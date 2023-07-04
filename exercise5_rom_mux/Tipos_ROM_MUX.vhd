library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

Package Tipos_ROM_MUX is -- En este paquete defino mis tipos
				 -- de datos constantes y señales globales, subprogramas, etc.
				 -- El tipo Tabla es común para generar una ROM ó un Multiplexor.
	constant N_Bits_Dato : natural := 8;
	type Tabla is array (Natural range <> ) of STD_LOGIC_VECTOR(N_Bits_Dato - 1 downto 0);
end Tipos_ROM_MUX;
