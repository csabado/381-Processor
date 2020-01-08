library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity sign_extension is
  port(i          : in std_logic_vector(15 downto 0); 
       o          : out std_logic_vector(31 downto 0));
end sign_extension;

architecture dataflow of sign_extension is
begin

  o<= x"FFFF"& i;
  
end dataflow; 