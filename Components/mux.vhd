library IEEE;
use IEEE.std_logic_1164.all;

entity mux is
  port(y0          : in std_logic;
	y1          : in std_logic;  
	sel          : in std_logic;
	z          : out std_logic);

end mux;

architecture structure of mux is

component invg
  port(i_A  : in std_logic;
       o_F  : out std_logic);
end component;

component andg2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component org2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;
 
signal sel_i : std_logic;
signal y0_a : std_logic;
signal y1_a : std_logic;

begin

invg_i: invg
	port map(i_A => sel,
		o_F =>sel_i);
andg2_1: andg2
	port map(i_A => y0,
		i_B => sel_i,
		o_F =>y0_a);
andg2_2: andg2
	port map(i_A => y1,
		i_B => sel,
		o_F =>y1_a);
org2_2: org2
	port map(i_A => y0_a,
		i_B => y1_a,
		o_F =>z);
  
end structure;