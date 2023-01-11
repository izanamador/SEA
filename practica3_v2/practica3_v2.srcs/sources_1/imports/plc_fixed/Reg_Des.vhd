----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2019 14:11:16
-- Design Name: 
-- Module Name: Reg_Des - Simple
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

entity Reg_Des is

    generic( n     : integer := 8);
    Port   ( d     : in STD_LOGIC;
             q     : out STD_LOGIC_VECTOR(n-1 downto 0);
             reset : in STD_LOGIC;
             des   : in STD_LOGIC;
             clk   : in STD_LOGIC);
end Reg_Des;

architecture Simple of Reg_Des is

signal temp : std_logic_vector(n-1 downto 0);
    
begin
 
    process(clk,reset)
    begin
        if reset='1' then
	   
		  temp <= (others => '0');
		  
		elsif rising_edge(clk) then
        
            if des='1' then
            
			     for i in temp'high downto 1 loop
			     
				        temp(i) <= temp(i-1);
			     end loop;
			     temp(0) <= d;
 		     end if;
  	     end if;
    end process;
    q <= temp;
end Simple;
