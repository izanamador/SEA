----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2019 18:58:47
-- Design Name: 
-- Module Name: Mis_Tipos_PLC - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

Package Tipos_FSM_PLC is    -- En este paquete defino mis tipos
                            -- de datos constantes y señales globales, subprogramas, etc.
                            -- El tipo Tabla es común para generar una ROM ó un Multiplexor.
    constant N_Bits_Dato : Natural := 32; -- Anchura del dato de la tabla.                            
    type Tabla_FSM is array( Natural range <> ) of STD_LOGIC_VECTOR( N_Bits_Dato - 1 downto 0 );
                            -- Requerimientos de E/S del enunciado:
    constant       k_Max : natural := 3;   -- 3 entradas como máximo.
    constant       p_Max : natural := 4;   -- p salidas como máximo.
    constant       m_Max : natural := 4;   -- m biestables como máximo. (Hasta 16 estados)
end Tipos_FSM_PLC;

