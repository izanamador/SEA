----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2019 14:20:24
-- Design Name: 
-- Module Name: CKE_Gen - FSM_Simple
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

entity CKE_Gen is
    Port ( I : in STD_LOGIC;
           O : out STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC);
type Estado is ( E_1, E_2, E_3); --3 Estados.           
end CKE_Gen;

architecture FSM_Simple of CKE_Gen is
signal EA, PE : Estado; -- EA es el estado actual y PE es el próximo estado.
begin

Secuencial: process(clk,reset)
			begin
				if reset='1' then
				    EA<= E_1;
				elsif rising_edge(clk) then
				    EA<= PE;
				end if;
			end process Secuencial;
			
Combinacional: process(I,EA)
				begin
					case EA is
					when E_1 =>
						O <= '0';
						if I='0' then
						  PE <= E_1;
						else
						  PE <= E_2;
						end if;
                    when E_2 =>
				        O  <= '1';
				        PE <= E_3;
			        when E_3 =>
				        O <= '0';
				        if I='0' then
				            PE <= E_1;
				        else
				            PE <= E_3;
				        end if;
			        end case;
		end process Combinacional;
end FSM_Simple;
