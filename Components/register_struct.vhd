library IEEE;
use IEEE.std_logic_1164.all;

entity register_struct is
  generic(N : integer :=32);
  port(clk        : in std_logic;     -- Clock input
       rst        : in std_logic;     -- Reset input
       wr         : in std_logic;     -- Write enable input
       data       : in std_logic_vector(N-1 downto 0);     -- Data value input
       output     : out std_logic_vector(N-1 downto 0));   -- Data value output

end register_struct;

architecture structure of register_struct is

component dff
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;
 
begin

G1: for i in 0 to N-1 generate
  dff_i: dff
    port map(i_CLK  => clk,
  	     i_RST => rst,
	     i_WE  => wr,
	     i_D  => data(i),
	     o_Q   => output(i));
end generate;

  
end structure;