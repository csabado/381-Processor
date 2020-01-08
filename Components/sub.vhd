library IEEE;
use IEEE.std_logic_1164.all;

entity sub is
  port(y0          : in std_logic;
	y1          : in std_logic;  
	bi          : in std_logic;
	z          : out std_logic;
	bo          : out std_logic);

end sub;

architecture structure of sub is

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

component invg

  port(i_A          : in std_logic;
       o_F          : out std_logic);

end component;
 
signal xor_ab,a_inv,and_bna,inv_xor_ab,and_xor : std_logic;
signal and_ab : std_logic;
signal and_abc : std_logic;

begin

xorg2_1: xorg2
	port map(i_A => y0,
		i_B => y1,
		o_F =>xor_ab);
xorg2_2: xorg2
	port map(i_A => xor_ab,
		i_B => bi,
		o_F =>z);

invg_1: invg
	port map(i_A =>y0,
       o_F=>a_inv);

andg2_1: andg2
	port map(i_A => y1,
		i_B => a_inv,
		o_F =>and_bna);

invg_2: invg
	port map(i_A =>xor_ab,
       o_F=>inv_xor_ab);

andg2_2: andg2
	port map(i_A => inv_xor_ab,
		i_B => bi,
		o_F =>and_xor);
org2_1: org2
	port map(i_A => and_bna,
		i_B => and_xor,
		o_F =>bo);

end structure;