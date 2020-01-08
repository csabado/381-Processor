library IEEE;
use IEEE.std_logic_1164.all;

entity bit_alu is
  port(sel      : in std_logic_vector(2 downto 0);
	a       : in std_logic;  
	b       : in std_logic;
	ci      : in std_logic;
	less	: in std_logic;
	z       : out std_logic;
	co      : out std_logic;
	set	: out std_logic;
	over	: out std_logic);

end bit_alu;

architecture mixed of bit_alu is

component adder
  port(y0          : in std_logic;
	y1          : in std_logic;  
	ci          : in std_logic;
	z          : out std_logic;
	co          : out std_logic);
end component;

--component sub
--  port(y0          : in std_logic;
--	y1          : in std_logic;  
--	bi          : in std_logic;
--	z          : out std_logic;
--	bo          : out std_logic);
--end component;

component org2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component andg2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component xorg2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component invg

  port(i_A          : in std_logic;
       o_F          : out std_logic);

end component;

component mux 
  port(y0          : in std_logic;
	y1          : in std_logic;  
	sel          : in std_logic;
	z          : out std_logic);

end component;

component mux_8
  port(data0       : in std_logic;
	data1       : in std_logic;
	data2       : in std_logic;
	data3       : in std_logic;
	data4       : in std_logic;
	data5       : in std_logic;
	data6       : in std_logic;
	data7       : in std_logic;
	sel       : in std_logic_vector(2 downto 0);
	output    : out std_logic);
end component;

signal o_add,o_sub,o_slt,o_or,o_and,o_xor,o_nand,o_nor: std_logic;
signal b_inv,a_inv,co_add,co_sub,co_mux :std_logic;


begin

invg_1: invg
  port map(i_A =>b,
       o_F=>b_inv);

adder_1: adder 
    port map(y0  => a,
  	     y1  => b,
	     ci  => ci,
	     co  => co_add,
	     z   => o_add);

subtractor: adder 
    port map(y0  => a,
  	     y1  => b_inv,
	     ci  => ci,
	     co  => co_sub,
	     z   => o_sub);

--sub_1: sub
--    port map(y0  => a,
--  	     y1  => b,
--	     bi  => ci,
--	     bo  => co_sub,
--	     z   => o_sub);
--invg_4: invg
--  port map(i_A =>a,
--       o_F=>a_inv);
--
--andg2_1: andg2
--  port map(i_A =>a_inv,
--       i_B =>b,
--       o_F =>o_slt);

org2_1: org2
	port map(i_A => a,
		i_B => b,
		o_F =>o_or);

andg2_2: andg2
  port map(i_A =>a,
       i_B =>b,
       o_F =>o_and);

xorg2_1: xorg2
	port map(i_A => a,
		i_B => b,
		o_F =>o_xor);

invg_2: invg
  port map(i_A =>o_and,
       o_F=>o_nand);

invg_3: invg
  port map(i_A =>o_or,
       o_F=>o_nor);

--mux_1: mux 
--  port map(y0 =>co_add,
--	y1=>co_sub, 
--	sel =>sel(0),
--	z => co);
co<= co_sub when sel="001" or sel="010" else
co_add when sel="000" else
'0';
over<= co_sub when sel="001" or sel="010" else
co_add when sel="000" else
'0';

mux_2: mux_8
  port map(data0=> o_add,
	data1 => o_sub,
	data2 => less,
	data3 => o_or,
	data4 => o_and,
	data5 => o_xor,
	data6 => o_nand,
	data7 => o_nor,
	sel  => sel,
	output=>z);

set<=o_sub;

end mixed;