use work.Mis_Tipos.all;  -- La biblioteca lógica WORK es implícita en cada diseño.

entity Mi_Logica_TB is   -- Por tanto todos mis packages pertenecen a ella.

end Mi_Logica_TB;

architecture Comportamiento of Mi_Logica_TB is

  signal s_sr     : Mi_Logica          := 'U';  -- Señales sin resolver (sr).
  signal s_r      : Mi_Logica_Resuelta := 'U';  -- Señales resueltas (r).

begin

  Bus_End_Point_1 : process  -- Fuente 1 para la señal resuelta (genera un driver).
  begin
    --¡Esta línea no compilará!
 --   s_sr <= '0' after 5 ns, '1' after 10 ns, 'X' after 12 ns;
    s_r  <= '0' after 5 ns, '1' after 10 ns, 'X' after 20 ns;
    wait;
  end process Bus_End_Point_1;

  Bus_End_Point_2 : process  --Fuente 2 para la señal resuelta (otro driver).
  begin
    -- ¡Esta línea no compilará!
  --  s_sr <= '0' after 5 ns, '1' after 12 ns, 'X' after 15 ns;
    s_r  <= '0' after 5 ns, '1' after 12 ns, 'X' after 15 ns;
    wait;
  end process Bus_End_Point_2;

end Comportamiento;
