library IEEE;
use IEEE.std_logic_1164.all;

entity full_alu is
  port(sel         : in std_logic_vector(3 downto 0);
	a          : in std_logic_vector(31 downto 0);  
	b          : in std_logic_vector(31 downto 0);
	unsign	   : in std_logic;
--	ci	   : in std_logic;
	z          : out std_logic_vector(31 downto 0);
	co         : out std_logic;
	zero       : out std_logic;
	over       : out std_logic);

end full_alu;

architecture mixed of full_alu is

component bit_alu is
  port(sel      : in std_logic_vector(2 downto 0);
	a       : in std_logic;  
	b       : in std_logic;
	ci      : in std_logic;
	less	: in std_logic;
	z       : out std_logic;
	co      : out std_logic;
	set	: out std_logic;
	over	: out std_logic);

end component;

signal z_o,carry,sets,overflow : std_logic_vector(31 downto 0);
signal carry_in,a_negative,b_negative  : std_logic;

begin 

carry_in<='1' when sel="0001" or sel="0010" else
'0';

a_negative<='1' when unsign='0' and a(31)='1' else
'0';

b_negative<='1' when unsign='0' and b(31)='1' else
'0';

bitalu1:bit_alu
port map(sel=> sel(2 downto 0),
	a => a(0), 
	b =>b(0),
	ci=>carry_in,
	less=>sets(31),
	z=>z_o(0),
	co =>carry(0),
	set=>sets(0),
	over=>overflow(0));

G1: for i in 1 to 31 generate
bitalu2:bit_alu
port map(sel=> sel(2 downto 0),
	a => a(i), 
	b =>b(i),
	ci=>carry(i-1),
	less=>'0',
	z=>z_o(i),
	co =>carry(i),
	set=>sets(i),
	over=>overflow(i));
end generate;

zero <= '1' when z_o(31 downto 0)="00000000000000000000000000000000" else
'0';

over<='1' when (z_o(31)='1' and a_negative='0' and b_negative='0' and sel="0000")or (z_o(31)='0' and a_negative='1' and b_negative='1' and sel="0000")or(z_o(31)='1' and a_negative='0' and b_negative='1'and sel="0001")or(z_o(31)='0' and a_negative='1' and b_negative='0'and sel="0001") else
'0';

z<=z_o;
co<=carry(31);

end mixed;
