----------------------------------------------------------------------------------
-- Company: Universidad de M·laga
-- Engineer: Izan Amador, Jorge L. Benavides
--
-- Create Date: 23.11.2022 17:47:41
-- Design Name: sumador
-- Module Name: Test_Bench_Fichero - Behavioral
-- Project Name: sumador
-- Target Devices: Zybo 
-- Tool Versions: Vivado 2022.1
-- Description: basic test bench for a simple adder. 
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

  -- Registro universal a probar
  component registro is
    generic (
      n: integer
    );
    port (
      control: in std_logic_vector(2 downto 0);
      D: in std_logic_vector(n-1 downto 0);
      CLK: in std_logic;
      CKE: in std_logic;
      RESET: in std_logic;
      Q: out std_logic_vector(n-1 downto 0)
    );
  end component;
  
  -- Par·metros y seÒales
  constant n: integer := 8;
  signal clk_sig: std_logic;  -- SeÒal de reloj
  signal control_sig: std_logic_vector(2 downto 0);  -- SeÒal de control
  signal d_sig: std_logic_vector(n-1 downto 0);  -- SeÒal de datos de entrada
  signal cke_sig: std_logic;  -- SeÒal de enable de reloj
  signal reset_sig: std_logic;  -- SeÒal de reset
  signal q_sig: std_logic_vector(n-1 downto 0);  -- SeÒal de datos de salida
  
begin
  -- Instanciar el registro universal
  uut: registro generic map(n=>n)
    port map(control=>control_sig, D=>d_sig, CLK=>clk_sig, CKE=>cke_sig, RESET=>reset_sig, Q=>q_sig);
  
  -- Generador de reloj
  clk_gen: process
  begin
    clk_sig <= '0';
    wait for 5 ns;
    clk_sig <= '1';
    wait for 5 ns;
  end process;
  
 reset: process
      begin
      reset_sig <= '0';
      wait for 5 ns;
      reset_sig <= '1';
      cke_sig <= '1';
      wait for 5 ns;
      reset_sig <= '0';
      wait;
 end process;
  
  
  -- Pruebas
--  tb: process
--  begin
--    -- Inicializar seÒales
--    control_sig <= "000";
--    d_sig <= (others => '0');
--    cke_sig <= '1';
--    reset_sig <= '0';
    
--    -- Esperar algunas iteraciones de reloj
--    wait for 15 ns;
    
--    -- Cargar dato en el registro
--    d_sig <= "10101010";
--    control_sig <= "000";
--    wait for 5 ns;
    
--    -- Comprobar que el dato se ha cargado correctamente
--    assert q_sig = "10101010" report "Error: carga de dato incorrecta" severity error;
    
--    -- Finalizar
--    wait;
--  end process;

  Estimulos_Desde_Fichero : process

    file Input_File  : text;
    file Output_File : text;

    variable Input_Data   : BIT_VECTOR(10 downto 0) := (OTHERS => '0');
    variable Delay        : time                   := 0 ms;
    variable Input_Line   : line                   := NULL;
    variable Output_Line  : line                   := NULL;
    variable Std_Out_Line : line                   := NULL;
    variable Correcto     : Boolean                := True;
    constant Coma         : character              := ',';


  begin

-- sumador_Estimulos.txt contiene los est√≠mulos y los tiempos de retardo para el semisumador.
    file_open(Input_File, "C:\Users\izana\Documents\GitHub\SEA\Estimulos\practica2_Estimulos.txt", read_mode);

-- sumador_Estimulos.csv contiene los est√≠mulos y los tiempos de retardo para el Analog Discovery 2.
    file_open(Output_File, "C:\Users\izana\Documents\GitHub\SEA\CSV\practica2.csv", write_mode);

-- Titles: Son para el formato EXCEL *.CSV (Comma Separated Values):
    write(Std_Out_Line, string'("Retardo"), right, 7);
    write(Std_Out_Line, Coma, right, 1);
    write(Std_Out_Line, string'("Entradas"), right, 8);

    Output_Line := Std_Out_Line;

    writeline(output, Std_Out_Line);
    writeline(Output_File, Output_Line);

    while (not endfile(Input_File)) loop

      readline(Input_File, Input_Line);

      read(Input_Line, Delay, Correcto);  -- Comprobaci√≥n de que se trata de un texto que representa
      -- el retardo, si no es as√≠ leemos la siguiente l√≠nea.
      if Correcto then

        read(Input_Line, Input_Data);  -- El siguiente campo es el vector de pruebas.
        -- Der a Izq

        control_sig <= TO_STDLOGICVECTOR(Input_Data)(10 downto 8);
        d_sig <= TO_STDLOGICVECTOR(Input_Data)(7 downto 0);

        -- De forma simult√°nea lo volcaremos en consola en csv.
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