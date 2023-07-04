----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2022 16:07:32
-- Design Name: 
-- Module Name: Test_Bench_Process - Behavioral
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

entity Test_Bench_Process is
--  Port ( );
end Test_Bench_Process;

architecture Behavioral of Test_Bench_Process is

component     Sincronizador 
generic (m : integer := 1);
Port(
    I     : in  std_logic;
    CKE   : out std_logic;
    reset : in  std_logic;
    clk   : in  std_logic);
end Component Sincronizador;

signal 	I_interno, CKE_interno, reset_interno: STD_LOGIC := 'U';
signal clk_interno : STD_LOGIC := '0';
constant semiperiodo : time := 10 ns; 

begin

DUT : Sincronizador generic map (4) port map(I => I_interno, CKE => CKE_interno, reset => reset_interno, clk => clk_interno );

-- Taken from The Student Guide to VHDL, Peter J.Asheden 
clock_gen: process (clk_interno) is
begin
if clk_interno = '0' then
    clk_interno <= '1' after semiperiodo, 
                   '0' after 2*semiperiodo;
    end if;
    end process clock_gen;
    
reset: process
begin
reset_interno <= '0';
wait for 5 ns;
reset_interno <= '1';
wait for 5 ns;
reset_interno <= '0';
wait;
end process reset;

button: process
begin
-- Button pushed
I_interno <= '0';
wait for 1 ns;
I_interno <= '1';
wait for 3 ns;
I_interno <= '0';
wait for 2 ns;
I_interno <= '1';
wait for 5 ns;
I_interno <= '0';
wait for 1 ns;
I_interno <= '1';
wait for 7 ns;
I_interno <= '0';
wait for 5 ns;
I_interno <= '1';
wait for 100 ns;

-- Button free

I_interno <= '0';
wait for 5 ns;
I_interno <= '1';
wait for 7 ns;
I_interno <= '0';
wait for 2 ns;
I_interno <= '1';
wait for 1 ns;
I_interno <= '0';
wait for 4 ns;
I_interno <= '1';
wait for 6 ns;
I_interno <= '0';
wait;

end process;

end Behavioral;
