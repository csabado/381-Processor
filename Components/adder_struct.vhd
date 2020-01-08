library IEEE;
use IEEE.std_logic_1164.all;

entity adder_struct is
  generic(N : integer :=32);
   port(y0          : in std_logic_vector(N-1 downto 0);
	y1          : in std_logic_vector(N-1 downto 0);
	ci          : in std_logic;  
	co          : out std_logic;
	z           : out std_logic_vector(N-1 downto 0));

end adder_struct;

architecture structure of adder_struct is

component adder
  port(y0          : in std_logic;
	y1          : in std_logic;  
	ci          : in std_logic;
	z          : out std_logic;
	co          : out std_logic);
end component;

signal t : std_logic_vector(N-1 downto 0);

begin

adder_1: adder 
    port map(y0  => y0(0),
  	     y1  => y1(0),
	     ci  => ci,
	     co  => t(0),
	     z   => z(0));

G1: for i in 1 to N-1 generate
  adder_2: adder 
    port map(y0  => y0(i),
  	     y1  => y1(i),
	     ci  => t(i-1),
	     co  => t(i),
	     z   => z(i));
end generate;
co<= t(N-1);
  
end structure;