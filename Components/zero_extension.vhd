library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity zero_extension is
  port(i          : in std_logic_vector(15 downto 0); 
       o          : out std_logic_vector(31 downto 0));
end zero_extension;

architecture dataflow of zero_extension is
begin

  o<= x"0000"& i;
  
end dataflow; 