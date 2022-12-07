----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2022 15:32:00
-- Design Name: 
-- Module Name: Mis_Tipos - Behavioral
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


Package Mis_Tipos is
-- En este paquete defino mis tipos de datos constantes
-- y señales globales, subprogramas, etc.

  type Mi_Logica is ('U', '0', '1', 'X');  -- La lógica base no resuelta.
  type Mi_Logica_Vector is array(Natural range <>) of Mi_Logica;

  --La función de resolución cumple la Conmutativa, Asociativa y Elemento Neutro.
  function Resuelve(x : Mi_Logica_Vector)
    return Mi_Logica;

  subtype Mi_Logica_Resuelta is Resuelve Mi_Logica;  -- El tipo resuelto como

end Mis_Tipos;  -- subtipo del tipo base.

package body Mis_Tipos is  -- Aquí defino el cuerpo de los subprogramas.

  function Resuelve(x : Mi_Logica_Vector) return Mi_Logica is
    type Tabla is array(Mi_Logica range 'U' to 'X', Mi_Logica range 'U' to 'X')

      of Mi_Logica;
--'U' '0' '1' 'X'
----------------------
    constant Operacion : Tabla := (('U', '0', '1', 'X'),   --|’U’
                                   ('0', '0', 'X', 'X'),   --|’0’
                                   ('1', 'X', '1', 'X'),   --|’1’
                                   ('X', 'X', 'X', 'X'));  --|’X’
    variable Parcial : Mi_Logica := 'U';  -- El valor inicial es importante:

  begin  -- Siempre es el Elemento Neutro.

    for i in x'Range loop
      Parcial := Operacion(Parcial, x(i));  -- Recursión con propiedades:
-- Asociativa:f(f(x,y),z)=f(x,f(y,z))
    end loop;  -- Conmutativa: f(x,y)=f(y,x)

    return Parcial;

  end Resuelve;

end Mis_Tipos;
