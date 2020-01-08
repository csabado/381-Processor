library IEEE;
use IEEE.std_logic_1164.all;

entity mux_dataflow is
   port(y0          : in std_logic_vector(31 downto 0);
	y1          : in std_logic_vector(31 downto 0);  
	sel         : in std_logic;
	z           : out std_logic_vector(31 downto 0));

end mux_dataflow;

architecture dataflow of mux_dataflow is


begin

z<=y0 when sel='0' else
y1;

  
end dataflow;