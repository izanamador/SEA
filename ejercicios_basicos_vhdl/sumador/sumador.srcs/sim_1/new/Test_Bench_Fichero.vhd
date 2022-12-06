----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 19.10.2020 12:14:30
-- Design Name:
-- Module Name: Test_Bench - Comportamiento
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
use STD.textIO.ALL;                     -- Se va a hacer uso de ficheros.

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Test_Bench_Fichero is
--  Port ( );
end Test_Bench_Fichero;

architecture Comportamiento of Test_Bench_Fichero is

  component Sum
    generic(
      n : integer := 8);
    port(x : in  std_logic_vector(n-1 downto 0);
         y : in  std_logic_vector(n-1 downto 0);
         s : out std_logic_vector(n-1 downto 0));
  end Component Sum;

  constant n: integer := 2;
  signal x_interno, y_interno, s_interno : std_logic_vector(n-1 downto 0):= (others => 'U');

begin

  DUT : Sum
    generic map (n)
    port map(
      x => x_interno,
      y => y_interno,
      s => s_interno);

  Estimulos_Desde_Fichero : process

    file Input_File  : text;
    file Output_File : text;

    variable Input_Data   : BIT_VECTOR(3 downto 0) := (OTHERS => '0');
    variable Delay        : time                   := 0 ms;
    variable Input_Line   : line                   := NULL;
    variable Output_Line  : line                   := NULL;
    variable Std_Out_Line : line                   := NULL;
    variable Correcto     : Boolean                := True;
    constant Coma         : character              := ',';


  begin

-- sumador_Estimulos.txt contiene los estímulos y los tiempos de retardo para el semisumador.
    file_open(Input_File, "C:\Users\izana\Documents\GitHub\SEA\Estimulos\sumador_Estimulos.txt", read_mode);

-- sumador_Estimulos.csv contiene los estímulos y los tiempos de retardo para el Analog Discovery 2.
    file_open(Output_File, "C:\Users\izana\Documents\GitHub\SEA\CSV\sumador_Estimulos.csv", write_mode);

-- Titles: Son para el formato EXCEL *.CSV (Comma Separated Values):
    write(Std_Out_Line, string'("Retardo"), right, 7);
    write(Std_Out_Line, Coma, right, 1);
    write(Std_Out_Line, string'("Entradas"), right, 8);

    Output_Line := Std_Out_Line;

    writeline(output, Std_Out_Line);
    writeline(Output_File, Output_Line);

    while (not endfile(Input_File)) loop

      readline(Input_File, Input_Line);

      read(Input_Line, Delay, Correcto);  -- Comprobación de que se trata de un texto que representa
      -- el retardo, si no es así leemos la siguiente línea.
      if Correcto then

        read(Input_Line, Input_Data);  -- El siguiente campo es el vector de pruebas.
        -- Der a Izq

        x_interno <= TO_STDLOGICVECTOR(Input_Data)(3 downto 2);
        y_interno <= TO_STDLOGICVECTOR(Input_Data)(1 downto 0);

        -- De forma simultánea lo volcaremos en consola en csv.
        write(Std_Out_Line, Delay, right, 5);  -- Longitud del retardo, ej. "20 ms".
        write(Std_Out_Line, Coma, right, 1);
        write(Std_Out_Line, Input_Data, right, 2);  --Longitud de los datos de entrada.

        Output_Line := Std_Out_Line;

        writeline(output, Std_Out_Line);
        writeline(Output_File, Output_Line);

        wait for Delay;
      end if;
    end loop;

    file_close(Input_File);             -- Cerramos el fichero de entrada.
    file_close(Output_File);            -- Cerramos el fichero de salida.
    wait;
  end process Estimulos_Desde_Fichero;


end Comportamiento;
