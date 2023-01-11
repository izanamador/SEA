----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2019 13:54:47
-- Design Name: 
-- Module Name: Debouncer - Simple
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

entity Debouncer is
    generic ( n     : natural := 4 );
    Port    ( I     : in STD_LOGIC;
              O     : out STD_LOGIC;
              reset : in STD_LOGIC;
              clk   : in STD_LOGIC );
end Debouncer;

architecture Simple of Debouncer is

signal   s         : STD_LOGIC_VECTOR(3 downto 0);
signal   Resultado : STD_LOGIC; -- Contiene la AND de todos los bits de s.
component Reg_Des is
    generic( n     : integer);
    port   ( d     : in STD_LOGIC;
             q     : out STD_LOGIC_VECTOR(n-1 downto 0);
             reset : in STD_LOGIC;
             des   : in STD_LOGIC;
             clk   : in STD_LOGIC);
end component Reg_Des;

begin

Registro: Reg_Des   generic map(n)
                    port map(d=>I,q=>s,reset=>reset, des=>'1', clk=>clk);
AND_n : process(s)
    variable Parcial : STD_LOGIC;
    begin
        parcial := '1';
        for i in 0 to n - 1 loop
            Parcial := Parcial and s( i );
        end loop;
        Resultado <= Parcial;
    end process AND_n;

    O <= transport '1' after 1 ns when Resultado = '1' else '0' after 1 ns;

end Simple;
