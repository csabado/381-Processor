library IEEE;
use IEEE.std_logic_1164.all;

entity ifid is
  port(clk        : in std_logic;
       rst        : in std_logic;
       stall      : in std_logic;
       instr      : in std_logic_vector(31 downto 0);
       pc         : in std_logic_vector(31 downto 0);
       instrO     : out std_logic_vector(31 downto 0);
       pcO        : out std_logic_vector(31 downto 0));

end ifid;

architecture structure of ifid is

component dff
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

signal wr: std_logic;

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
  
end structure;