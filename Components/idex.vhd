library IEEE;
use IEEE.std_logic_1164.all;

entity idex is
  port(clk      	: in std_logic;
       	rst     	: in std_logic;
       	stall   	: in std_logic;
       	instr   	: in std_logic_vector(31 downto 0);
       	pc     		: in std_logic_vector(31 downto 0);
	alusrc 		: in std_logic;
	aluctrl 	: in std_logic_vector(3 downto 0);
	memtoreg	: in std_logic;
	dmemwr		: in std_logic;
	regwr		: in std_logic;
	regdst		: in std_logic;
	unsign		: in std_logic;
	jal		: in std_logic;
	imm		: in std_logic_vector(31 downto 0);
	rs		: in std_logic_vector(31 downto 0);
	rt		: in std_logic_vector(31 downto 0);

	instrO  	: out std_logic_vector(31 downto 0);
      	pcO     	: out std_logic_vector(31 downto 0);
       	alusrcO 	: out std_logic;
	aluctrlO 	: out std_logic_vector(3 downto 0);
	memtoregO	: out std_logic;
	dmemwrO		: out std_logic;
	regwrO		: out std_logic;
	regdstO		: out std_logic;
	unsignO		: out std_logic;
	jalO		: out std_logic;
	immO		: out std_logic_vector(31 downto 0);
	rsO		: out std_logic_vector(31 downto 0);
	rtO		: out std_logic_vector(31 downto 0));	

end idex;

architecture structure of idex is

component dff
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

signal wr : std_logic;

begin

wr<= '0' when stall='1' else
'1';

G1: for i in 0 to 31 generate
  dff_1: dff
    port map(i_CLK  => clk,
  	     i_RST => rst,
	     i_WE  => wr,
	     i_D  => instr(i),
	     o_Q   => instrO(i));
end generate;

G2: for i in 0 to 31 generate
  dff_2: dff
    port map(i_CLK  => clk,
  	     i_RST => rst,
	     i_WE  => wr,
	     i_D  => pc(i),
	     o_Q   => pcO(i));
end generate;

dff_3: dff
    port map(i_CLK  => clk,
  	     i_RST => rst,
	     i_WE  => wr,
	     i_D  => alusrc,
	     o_Q   => alusrcO);

G3: for i in 0 to 3 generate
  dff_4: dff
    port map(i_CLK  => clk,
  	     i_RST => rst,
	     i_WE  => wr,
	     i_D  => aluctrl(i),
	     o_Q   => aluctrlO(i));
end generate;

dff_5: dff
    port map(i_CLK  => clk,
  	     i_RST => rst,
	     i_WE  => wr,
	     i_D  => memtoreg,
	     o_Q   => memtoregO);

dff_6: dff
    port map(i_CLK  => clk,
  	     i_RST => rst,
	     i_WE  => wr,
	     i_D  => dmemwr,
	     o_Q   => dmemwrO);

dff_7: dff
    port map(i_CLK  => clk,
  	     i_RST => rst,
	     i_WE  => wr,
	     i_D  => regwr,
	     o_Q   => regwrO);

dff_8: dff
    port map(i_CLK  => clk,
  	     i_RST => rst,
	     i_WE  => wr,
	     i_D  => regdst,
	     o_Q   => regdstO);

dff_9: dff
    port map(i_CLK  => clk,
  	     i_RST => rst,
	     i_WE  => wr,
	     i_D  => unsign,
	     o_Q   => unsignO);

dff_13: dff
    port map(i_CLK  => clk,
  	     i_RST => rst,
	     i_WE  => wr,
	     i_D  => jal,
	     o_Q   => jalO);

G4: for i in 0 to 31 generate
  dff_15: dff
    port map(i_CLK  => clk,
  	     i_RST => rst,
	     i_WE  => wr,
	     i_D  => imm(i),
	     o_Q   => immO(i));
end generate;

G5: for i in 0 to 31 generate
  dff_16: dff
    port map(i_CLK  => clk,
  	     i_RST => rst,
	     i_WE  => wr,
	     i_D  => rs(i),
	     o_Q   => rsO(i));
end generate;

G6: for i in 0 to 31 generate
  dff_17: dff
    port map(i_CLK  => clk,
  	     i_RST => rst,
	     i_WE  => wr,
	     i_D  => rt(i),
	     o_Q   => rtO(i));
end generate;
  
end structure;