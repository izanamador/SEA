library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BancoDePruebas is
end BancoDePruebas;

architecture Behavioral of BancoDePruebas is
component SemiSumador 
    Port (
    a,b : in STD_LOGIC;
    s,c : out STD_LOGIC);
    end component SemiSumador;
    signal x,y,Suma,Acarreo : STD_LOGIC := 'U';
    constant PERIODO : time := 50 ns;
begin
    DUT: SemiSumador 
    port map(
    a => y,
    b => x,
    s => Suma,
    c => Acarreo);
    Estimulo_X : process
    begin
    x <= '0';
        wait for PERIODO/4;
        x <= '1';
        wait for PERIODO/4;
end process Estimulo_X;

   Estimulo_Y : process
    begin
    y <= '0';
    wait for PERIODO/2;
    y <= '1';
    wait for PERIODO/2;
end process Estimulo_Y;
end Behavioral;
 
