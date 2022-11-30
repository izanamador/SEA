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

entity Test_Bench is
--  Port ( );
end Test_Bench;

architecture Comportamiento of Test_Bench is

  component top
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
  end Component top;

  constant semiperiodo : time := 10 ns;
  constant periodo : time := 2*semiperiodo;
  constant counter_size: integer := 4;
  constant filter_size : integer := 4;
  signal jc_in_interno : std_logic_vector(counter_size-1 downto 0) := (others => 'U');
  signal reset_interno, fdc_interno : std_logic := 'U';
  signal clk_interno, ce_interno, load_interno : std_logic := '0';
  signal jd_out_interno : std_logic_vector(counter_size-1 downto 0) := (others => 'U');
begin

  DUT : top
  generic map (counter_size, filter_size)
    port map(
      jc_in  => jc_in_interno,
      reset  => reset_interno,
      ce     => ce_interno,
      load   => load_interno,
      clk    => clk_interno,
      jd_out => jd_out_interno,
      fdc    => fdc_interno);

  clock_gen: process (clk_interno) is
  begin
    if clk_interno = '0' then
      clk_interno <= '1' after semiperiodo,
                     '0' after periodo;
    end if;
  end process clock_gen;

  reset: process
  begin
    reset_interno <= '0';
    wait for 2*periodo;
    reset_interno <= '1';
    wait for 1*periodo;
    reset_interno <= '0';
    wait;
  end process reset;

  
  load: process (load_interno) is
    begin
      if load_interno = '0' then
        load_interno <= '1' after 200*periodo,
                       '0' after 201*periodo;
      end if;
    end process load;

  
  ce: process (ce_interno) is
    begin
      if ce_interno = '0' then
        ce_interno <= '1' after 2*periodo,
                       '0' after 4*periodo;
      end if;
    end process ce;


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

-- Contador_Asc_Top_Estimulos.txt contiene los estímulos y los tiempos de retardo para el semisumador.
    file_open(Input_File, "C:\Users\izana\Documents\GitHub\SEA\Estimulos\Contador_Asc_Top_Estimulos.txt", read_mode);
-- Contador_Asc_Top_Estimulos.csv contiene los estímulos y los tiempos de retardo para el Analog Discovery 2.
    file_open(Output_File, "C:\Users\izana\Documents\GitHub\SEA\CSV\Contador_Asc_Top_Estimulos.csv", write_mode);

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

        jc_in_interno <= TO_STDLOGICVECTOR(Input_Data)(3 downto 0);

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
