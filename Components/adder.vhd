library IEEE;
use IEEE.std_logic_1164.all;

entity adder is
  port(y0          : in std_logic;
	y1          : in std_logic;  
	ci          : in std_logic;
	z          : out std_logic;
	co          : out std_logic);

end adder;

architecture structure of adder is

component xorg2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
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
 
signal xor_ab : std_logic;
signal and_ab : std_logic;
signal and_abc : std_logic;

begin

xorg2_1: xorg2
	port map(i_A => y0,
		i_B => y1,
		o_F =>xor_ab);
xorg2_2: xorg2
	port map(i_A => xor_ab,
		i_B => ci,
		o_F =>z);
andg2_1: andg2
	port map(i_A => y0,
		i_B => y1,
		o_F =>and_ab);
andg2_2: andg2
	port map(i_A => xor_ab,
		i_B => ci,
		o_F =>and_abc);
org2_2: org2
	port map(i_A => and_ab,
		i_B => and_abc,
		o_F =>co);
  
end structure;