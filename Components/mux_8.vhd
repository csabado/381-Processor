library IEEE;
use IEEE.std_logic_1164.all;

entity mux_8 is

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

end mux_8;

architecture dataflow of mux_8 is


begin

output <= data0 when sel = "000" else 
data1 when sel = "001" else 
data2 when sel = "010" else 
data3 when sel = "011" else 
data4 when sel = "100" else 
data5 when sel = "101" else 
data6 when sel = "110" else 
data7 when sel = "111";

end dataflow;