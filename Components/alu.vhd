library IEEE;
use IEEE.std_logic_1164.all;

entity alu is
  port(sel         : in std_logic_vector(3 downto 0);
	a          : in std_logic_vector(31 downto 0);  
	b          : in std_logic_vector(31 downto 0);
	shamt	   : in std_logic_vector(4 downto 0);
	unsign	   : in std_logic;
	z          : out std_logic_vector(31 downto 0);
	co         : out std_logic;
	zero       : out std_logic;
	over       : out std_logic);

end alu;


architecture structure of alu is

component full_alu is
  port(sel         : in std_logic_vector(3 downto 0);
	a          : in std_logic_vector(31 downto 0);  
	b          : in std_logic_vector(31 downto 0);
	unsign	   : in std_logic;
	z          : out std_logic_vector(31 downto 0);
	co         : out std_logic;
	zero       : out std_logic;
	over       : out std_logic);
end component;

component mux_struct is
  generic(N : integer :=32);
   port(y0          : in std_logic_vector(N-1 downto 0);
	y1          : in std_logic_vector(N-1 downto 0);  
	sel         : in std_logic;
	z           : out std_logic_vector(N-1 downto 0));

end component;

component shifter is
port( 	a	: in STD_LOGIC_VECTOR (31 downto 0);
	shamt	: in STD_LOGIC_VECTOR(4 downto 0);
	sel	: in STD_LOGIC_VECTOR(3 downto 0);
	c	: out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal shift_amount : std_logic_vector(4 downto 0);
signal shifted_a,z_alu,to_shift : std_logic_vector(31 downto 0);


begin

shift_amount<= a(4 downto 0) when sel="1100"or sel="1101"or sel="1111" else 
"10000" when sel="1110" else
shamt;


shifter0:shifter
port map(a=>b,
	shamt=>shift_amount,
	sel=>sel,
	c=>shifted_a);

alu_full:full_alu
port map(sel=>sel,
	a=>a, 
	b=>b,
	unsign=>unsign,
	z=>z_alu,
	co=>co,
	zero=>zero,
	over=>over);
mux:mux_struct
port map(y0=>z_alu,
	y1=>shifted_a, 
	sel=>sel(3),
	z=>z);

end structure;