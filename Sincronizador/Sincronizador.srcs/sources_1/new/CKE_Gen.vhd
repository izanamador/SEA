----------------------------------------------------------------------------------
-- Company: Universidad de Málaga
-- Engineer: Izan Amador, Jorge L. Benavides
--
-- Create Date: 23.11.2022 17:47:41
-- Design Name: Debouncer
-- Module Name: CKE_Gen - Behavioral
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
-- Generic pulse generator
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CKE_Gen is
  port(
    I : in std_logic;
    O : out std_logic;
    reset: in std_logic;
    clk : in std_logic);
  type Estado is (E_1,E_2,E_3);
end CKE_Gen;

architecture Behavioral of CKE_Gen is
  signal EA, PE : Estado;
begin
  Secuencial: process(clk,reset)
  begin
    if reset = '1' then EA <= E_1;
    elsif rising_edge(clk) then EA <= PE;
    end if;
  end process Secuencial;
  Combinacional: process(I,EA)
  begin
    case EA is
      when E_1 =>
        O <= '0';
        if I = '0' then PE <= E_1;
        else PE <= E_2;
        end if;
      when E_2 =>
        O <= '1';
        PE <= E_3;
      when E_3 =>
        O <= '0';
        if I = '0' then PE <= E_1;
        else PE <= E_3;
        end if;
    end case;
  end process Combinacional;
end Behavioral;
