library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder is
    Port ( A : in  std_logic_vector(7 downto 0);
           B : in  std_logic_vector(7 downto 0);
           Cin : in  std_logic;
           Sum : out  std_logic_vector(7 downto 0);
           Cout : out  std_logic);
end Adder;

architecture Behavioral of Adder is
    component FullAdder
        Port ( A : in  STD_LOGIC;
               B : in  STD_LOGIC;
               Cin : in  STD_LOGIC;
               Sum : out  STD_LOGIC;
               Cout : out  STD_LOGIC);
    end component;

begin
    variable i : integer;
    Sum(0) <= A(0) xor B(0) xor Cin;
    Cout <= (A(0) and B(0)) or (A(0) and Cin) or (B(0) and Cin);

    for i in 1 to 7 loop
        adder_inst: FullAdder port map(A => A(i), B => B(i), Cin => Cout, Sum => Sum(i), Cout => Cout);
    end loop;

end Behavioral;
