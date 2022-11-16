----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2022 17:25:28
-- Design Name: 
-- Module Name: Antirrebotes - Behavioral
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

entity Antirrebotes is
    port(
        I : in std_logic;
        O : out std_logic;
        reset : in std_logic;
        clk : in std_logic
    );
end Antirrebotes;

architecture Behavioral of Antirrebotes is
signal s : std_logic_vector (3 downto 0);

component Reg_Des is
    generic(n: integer);
    port(
        d : in std_logic;
        q : out std_logic_vector (n-1 downto 0);
        reset, des : in std_logic ;
        clk : in std_logic);
end component;        
begin
Registro : Reg_Des 
    generic map (4)
    port map(
        d => I,
        q => s,
        reset => reset,
        des => '1',
        clk => clk);
    O <= transport '1' after 1 ns when s = "1111" else '0' after 1 ns;
end Behavioral;
