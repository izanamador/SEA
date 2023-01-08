----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.01.2023 20:56:31
-- Design Name: 
-- Module Name: registro - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Registro universal de n bits genérico y esquema FSM
-- Entidad del registro universal
entity registro is
generic (n: integer := 8);
  port(
    CLK:       in  std_logic;
    CKE:       in  std_logic;
    RESET:     in  std_logic;
    Control:   in  std_logic_vector(2 downto 0);
    D:         in  std_logic_vector(n-1 downto 0);
    Q:         out std_logic_vector(n-1 downto 0)
  );
end entity;


-- Arquitectura del registro universal

  architecture Behavioral of Registro is
    type State_Type is (S_LOAD, S_COUNT_UP, S_COUNT_DOWN, S_SHIFT_LEFT, S_SHIFT_RIGHT);
    signal state : State_Type;
    signal r : std_logic_vector(n-1 downto 0);
  begin
    process (clk, reset, control, d)
      variable r_aux : std_logic_vector(n-1 downto 0);
    begin
      if reset = '1' then
        state <= S_LOAD;
      elsif rising_edge(clk) then
        case state is
          when S_LOAD =>
            if Control(2 downto 0) = "000" then
              -- Carga el dato
              r <= d;
              state <= S_LOAD;
            elsif Control(2 downto 0) = "001" then
              state <= S_COUNT_UP;
            elsif Control(2 downto 0) = "010" then
              state <= S_COUNT_DOWN;
            elsif Control(2 downto 0) = "011" then
              state <= S_SHIFT_LEFT;
            elsif Control(2 downto 0) = "100" then
              state <= S_SHIFT_RIGHT;
            else
              -- Conserva el dato
              state <= S_LOAD;
            end if;
          when S_COUNT_UP =>
            -- Conteo ascendente
            r_aux(n-1 downto 1) := r(n-2 downto 0);
            r_aux(0) := '0';
            r <= r_aux;
            state <= S_COUNT_UP;
          when S_COUNT_DOWN =>
            -- Conteo descendente
            r_aux(n-1 downto 1) := r(n-2 downto 0);
            r_aux(0) := '1';
            r <= r_aux;
            state <= S_COUNT_DOWN;
          when S_SHIFT_LEFT =>
            -- Desplaza a la izquierda
            r_aux(0) := '0';
            for i in 1 to n-1 loop
              r_aux(i-1) := r(i);
            end loop;
            r <= r_aux;
            state <= S_SHIFT_LEFT;
          when S_SHIFT_RIGHT =>
            -- Desplaza a la derecha
            r_aux(n-1) := '0';
            for i in 1 to n-1 loop
              r_aux(i) := r(i-1);
            end loop;
            r <= r_aux;
            state <= S_SHIFT_RIGHT;
        end case;
      end if;
    end process;
    Q <= r;
  end Behavioral;





























































































