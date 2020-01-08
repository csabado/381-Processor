library IEEE;
use IEEE.std_logic_1164.all;

entity write_enable is

  port(we       : in std_logic;
	enables : in std_logic_vector(31 downto 0);
       output    : out std_logic_vector(31 downto 0));

end write_enable;

architecture dataflow of write_enable is


begin

output <= "00000000000000000000000000000000" when we = '0' else 
enables; 
end dataflow;