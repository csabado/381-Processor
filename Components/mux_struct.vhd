library IEEE;
use IEEE.std_logic_1164.all;

entity mux_struct is
  generic(N : integer :=32);
   port(y0          : in std_logic_vector(N-1 downto 0);
	y1          : in std_logic_vector(N-1 downto 0);  
	sel         : in std_logic;
	z           : out std_logic_vector(N-1 downto 0));

end mux_struct;

architecture structure of mux_struct is

component mux
  port(y0          : in std_logic;
	y1          : in std_logic;  
	sel          : in std_logic;
	z          : out std_logic);
end component;
 
begin

G1: for i in 0 to N-1 generate
  mux_i: mux 
    port map(y0  => y0(i),
  	     y1  => y1(i),
	     sel => sel,
	     z   => z(i));
end generate;

  
end structure;