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
use work.Tipos_FSM_PLC.all;

entity Test_Bench is
end Test_Bench;

architecture Comportamiento of Test_Bench is

  component FSM_PLC
    generic( k    : natural := 32;    -- k entradas.
             p    : natural := 32;    -- p salidas.
             m    : natural := 32;    -- m biestables. (Hasta 16 estados)
             T_DM : time    := 10 ps; -- Tiempo de retardo desde el cambio de dirección del MUX hasta la actualización de la salida Q.
             T_D  : time    := 10 ps; -- Tiempo de retardo desde el flanco activo del reloj hasta la actualización de la salida Q.
             T_SU : time    := 10 ps; -- Tiempo de Setup.
             T_H  : time    := 10 ps; -- Tiempo de Hold.
             T_W  : time    := 10 ps); -- Anchura de pulso.
    port   (x : in  STD_LOGIC_VECTOR( k - 1 downto 0 );     -- x es el bus de entrada.
            y : out STD_LOGIC_VECTOR( p - 1 downto 0 );     -- y es el bus de salida.
            Tabla_De_Estado : in Tabla_FSM( 0 to 2**m - 1 );  -- Contiene la Tabla de Estado estilo Moore: Z(n+1)=T1(Z(n),x(n))
            Tabla_De_Salida : in Tabla_FSM( 0 to 2**m - 1 );  -- Contiene la Tabla de Salida estilo Moore: Y(n  )=T2(Z(n))
            clk     : in STD_LOGIC;   -- La señal de reloj.
            cke     : in STD_LOGIC;   -- La señal de habilitación de avance: si vale '1' el autómata avanza a ritmo de clk y si vale '0' manda Trigger.              
            reset   : in STD_LOGIC;   -- La señal de inicialización.
            Trigger : in STD_LOGIC ); -- La señal de disparo (single shot) asíncrono y posíblemente con rebotes para hacer un avance único. Ha de llevar un sincronizador.
  end component FSM_PLC;


  constant semiperiodo    : time    := 10 ns;
  constant k_interno      : natural := 3;
  constant p_interno      : natural := 4;
  constant m_interno      : natural := 4;
  


  signal x_interno: std_logic_vector(k_interno -1 downto 0) := (others => 'U');
  signal y_interno : std_logic_vector(p_interno -1 downto 0) := (others => 'U');
  
  -----------------------------------
  -- MOORE
  -----------------------------------
  
--  signal Tabla_De_Estado_interno : Tabla_FSM(0 to 2**m_interno-1) :=
--    ((4 => '1', others => '0'), -- 0
--     (5 => '1', others => '0'), -- 1
--     (5 => '1', 0|1 => '1', others => '0'), -- 2
--     (6 => '1', others => '0'), -- 3
--     (5 => '1', others => '0'), -- 4
--     -------------------------------------------------
--     (others => '0'), -- 5
--     (others => '0'), -- 6
--     (others => '0'), -- 7
--     (others => '0'), -- 8
--     (others => '0'), -- 9
--     (others => '0'), -- 10
--     (others => '0'), -- 11
--     (others => '0'), -- 12
--     (others => '0'), -- 13
--     (others => '0'), -- 14
--     (others => '0') -- 15
--);
--  signal Tabla_De_Salida_interno : Tabla_FSM(0 to 2**m_interno-1) :=
--    ((others => '0'), -- 0
--     (others => '0'), -- 0
--     (others => '0'), -- 0
--     (others => '0'), -- 0
--     (0 => '1', others => '0'), -- 1
--          -------------------------------------------------
--     (others => '0'), -- 5
--     (others => '0'), -- 6
--     (others => '0'), -- 7
--     (others => '0'), -- 8
--     (others => '0'), -- 9
--     (others => '0'), -- 10
--     (others => '0'), -- 11
--     (others => '0'), -- 12
--     (others => '0'), -- 13
--     (others => '0'), -- 14
--     (others => '0') -- 15
--     );
     
     -----------------------------------
       -- MEALY
       -----------------------------------
       
       signal Tabla_De_Estado_interno : Tabla_FSM(0 to 2**m_interno-1) :=
         ((4 => '1', others => '0'), -- 0
          (4 => '1',1 => '1', others => '0'), -- 1
          (4|5 => '1', others => '0'), -- 2
          (4 => '1', 2 => '1', others => '0'), -- 3
          (4 => '1',2 => '1',0 => '1', others => '0'), -- 4
          (4 => '1', others => '0'),
          -------------------------------------------------
          (others => '0'), -- 5
          (others => '0'), -- 6
          (others => '0'), -- 7
          (others => '0'), -- 8
          (others => '0'), -- 9
          (others => '0'), -- 10
          (others => '0'), -- 11
          (others => '0'), -- 12
          (others => '0'), -- 13
          (others => '0') -- 14
     );
       signal Tabla_De_Salida_interno : Tabla_FSM(0 to 2**m_interno-1) :=
         ((others => '0'), -- 0
          (others => '0'), -- 0
          (others => '0'), -- 0
          (others => '0'), -- 0
          (others => '0'), -- 0
          (0 => '1', others => '0'), -- 1
               -------------------------------------------------
          (others => '0'), -- 5
          (others => '0'), -- 6
          (others => '0'), -- 7
          (others => '0'), -- 8
          (others => '0'), -- 9
          (others => '0'), -- 10
          (others => '0'), -- 11
          (others => '0'), -- 12
          (others => '0'), -- 13
          (others => '0') -- 14
          );
  signal reset_interno, cke_interno, Trigger_interno : std_logic := 'U';
  signal clk_interno : std_logic := '0';


begin

  DUT : FSM_PLC
    generic map (
      k => k_interno,
      p => p_interno,
      m => m_interno)
    port map(
      x => x_interno,
      y => y_interno,
      Tabla_De_Estado => Tabla_De_Estado_interno,
      Tabla_De_Salida => Tabla_De_Salida_interno,
      Trigger => Trigger_interno,
      reset   => reset_interno,
      clk     => clk_interno,
      cke     => cke_interno);

-- Taken from The Student Guide to VHDL, Peter J.Asheden
  clock_gen : process (clk_interno) is
  begin
    if clk_interno = '0' then
      clk_interno <= '1' after semiperiodo,
                     '0' after 2*semiperiodo;
    end if;
  end process clock_gen;

  cke_interno <= '1';

  trigger: process
  begin
    trigger_interno <= '0';
    wait for 1 ns;
    trigger_interno <= '1';
    wait for 3 ns;
    trigger_interno <= '0';
    wait for 2 ns;
    trigger_interno <= '1';
    wait for 5 ns;
    trigger_interno <= '0';
    wait for 1 ns;
    trigger_interno <= '1';
    wait for 5 ns;
    trigger_interno <= '0';
    wait for 1 ns;
    trigger_interno <= '1';
    wait for 7 ns;
    trigger_interno <= '0';
    wait for 5 ns;
    trigger_interno <= '1';
    -- wait for 100 ns;

    wait;
  end process trigger;

  reset : process
  begin
    reset_interno <= '0';
    wait for 5 ns;
    reset_interno <= '1';
    wait for 5 ns;
    reset_interno <= '0';
    wait;
  end process reset;

  Estimulos_Desde_Fichero : process

    file Input_File  : text;
    file Output_File : text;

    variable Input_Data   : BIT_VECTOR(k_interno-1 downto 0) := (OTHERS => '0');
    variable Delay        : time                     := 0 ms;
    variable Input_Line   : line                     := NULL;
    variable Output_Line  : line                     := NULL;
    variable Std_Out_Line : line                     := NULL;
    variable Correcto     : Boolean                  := True;
    constant Coma         : character                := ',';


   begin
-- sumador_Estimulos.txt contiene los estÃ­mulos y los tiempos de retardo para el semisumador.
    file_open(Input_File, "C:\Users\izana\Documents\GitHub\SEA\Estimulos\practica3_mealy_Estimulos.txt", read_mode);
    --file_open(Input_File, "C:\Users\izana\Documents\GitHub\SEA\Estimulos\practica3_Estimulos.txt", read_mode);

-- sumador_Estimulos.csv contiene los estÃ­mulos y los tiempos de retardo para el Analog Discovery 2.
    file_open(Output_File, "C:\Users\izana\Documents\GitHub\SEA\CSV\practica3_mealy.csv", write_mode);
   -- file_open(Output_File, "C:\Users\izana\Documents\GitHub\SEA\CSV\practica3.csv", write_mode);

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
        x_interno <= TO_STDLOGICVECTOR(Input_Data);
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
