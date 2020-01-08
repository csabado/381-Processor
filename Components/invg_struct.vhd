library IEEE;
use IEEE.std_logic_1164.all;

entity invg_struct is
  generic(N : integer :=32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end invg_struct;

architecture structure of invg_struct is

component invg
  port(i_A  : in std_logic;
       o_F  : out std_logic);
end component;
 
begin

G1: for i in 0 to N-1 generate
  invg_i: invg 
    port map(i_A  => i_A(i),
  	     o_F  => o_F(i));
end generate;

  
end structure;