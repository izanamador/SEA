----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2019 19:05:32
-- Design Name: 
-- Module Name: Reg_PLC - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Reg_PLC is
   generic( N_Bits_Reg : integer := 8;
            T_D        : time := 10 ps ); -- Tiempo de retardo desde el flanco activo del reloj hasta la actualización de la salida Q.
   Port   ( D : in  STD_LOGIC_VECTOR(N_Bits_Reg-1 downto 0);
            Q : out STD_LOGIC_VECTOR(N_Bits_Reg-1 downto 0);
         reset : in STD_LOGIC;
           cke : in STD_LOGIC;
           clk : in STD_LOGIC);
end Reg_PLC;

architecture Comportamiento of Reg_PLC is
begin
Registro: process(clk,reset)
    begin
        if reset = '1' then
            Q <= (others => '0');
        elsif rising_edge(clk) then
            if cke = '1' then
                Q <= D after T_D;
            end if;
        end if;
    end process Registro;
end Comportamiento;