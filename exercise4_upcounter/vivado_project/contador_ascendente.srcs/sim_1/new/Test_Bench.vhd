----------------------------------------------------------------------------------
-- Company: Universidad de Málaga
-- Engineer: Izan Amador, Jorge L. Benavides
--
-- Create Date: 23.11.2022 17:47:41
-- Design Name: Debouncer
-- Module Name: Test_Bench - Behavioral
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
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.textIO.ALL;                     -- Se va a hacer uso de ficheros.

entity Test_Bench is
--  Port ( );
end Test_Bench;

architecture Comportamiento of Test_Bench is

  component Contador_Asc
    generic(n : integer := 8);
    port(din             : in  std_logic_vector(n-1 downto 0);
         dout            : out std_logic_vector(n-1 downto 0);
         reset, ce, load : in  std_logic;
         fdc             : out std_logic;
         clk             : in  std_logic);
  end Component Contador_Asc;


  constant semiperiodo : time    := 10 ns;
  constant n           : integer := 3;

  signal din_interno, dout_interno                            : std_logic_vector(n-1 downto 0) := (others => 'U');
  signal reset_interno, ce_interno, load_interno, fdc_interno : std_logic                      := 'U';
  signal clk_interno                                          : STD_LOGIC                      := '0';


begin

  DUT : Contador_Asc
    generic map (n)
    port map(
      din   => din_interno,
      dout  => dout_interno,
      reset => reset_interno,
      ce    => ce_interno,
      load  => load_interno,
      fdc   => fdc_interno,
      clk   => clk_interno);

-- Taken from The Student Guide to VHDL, Peter J.Asheden
  clock_gen : process (clk_interno) is
  begin
    if clk_interno = '0' then
      clk_interno <= '1' after semiperiodo,
                     '0' after 2*semiperiodo;
    end if;
  end process clock_gen;

  reset : process
  begin
    reset_interno <= '0';
    wait for 5 ns;
    reset_interno <= '1';
    wait for 5 ns;
    reset_interno <= '0';
    wait;
  end process reset;
  
  load_value : process
    begin
      load_interno <= '0';
      wait for 25 ns;
      load_interno <= '1';
      wait for 5 ns;
      load_interno <= '0';
      wait;
    end process load_value;

  count_enable : process
    begin
      ce_interno <= '0';
      wait for 45 ns;
      ce_interno <= '1';
      wait;
  end process count_enable;


  Estimulos_Desde_Fichero : process

    file Input_File  : text;
    file Output_File : text;

    variable Input_Data   : BIT_VECTOR(n-1 downto 0) := (OTHERS => '0');
    variable Delay        : time                   := 0 ms;
    variable Input_Line   : line                   := NULL;
    variable Output_Line  : line                   := NULL;
    variable Std_Out_Line : line                   := NULL;
    variable Correcto     : Boolean                := True;
    constant Coma         : character              := ',';


  begin

-- Contador_Asc_Estimulos.txt contiene los estímulos y los tiempos de retardo para el semisumador.
    file_open(Input_File, "C:\Users\izana\Documents\GitHub\SEA\Estimulos\Contador_Asc_Estimulos.txt", read_mode);
-- Contador_Asc_Estimulos.csv contiene los estímulos y los tiempos de retardo para el Analog Discovery 2.
    file_open(Output_File, "C:\Users\izana\Documents\GitHub\SEA\CSV\Contador_Asc_Estimulos.csv", write_mode);

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
        din_interno <= TO_STDLOGICVECTOR(Input_Data);
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
