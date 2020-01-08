library IEEE;
use IEEE.std_logic_1164.all;

entity mux_32 is

  port(data0       : in std_logic_vector(31 downto 0);
data1       : in std_logic_vector(31 downto 0);
data2       : in std_logic_vector(31 downto 0);
data3       : in std_logic_vector(31 downto 0);
data4       : in std_logic_vector(31 downto 0);
data5       : in std_logic_vector(31 downto 0);
data6       : in std_logic_vector(31 downto 0);
data7       : in std_logic_vector(31 downto 0);
data8       : in std_logic_vector(31 downto 0);
data9       : in std_logic_vector(31 downto 0);
data10       : in std_logic_vector(31 downto 0);
data11       : in std_logic_vector(31 downto 0);
data12       : in std_logic_vector(31 downto 0);
data13       : in std_logic_vector(31 downto 0);
data14       : in std_logic_vector(31 downto 0);
data15       : in std_logic_vector(31 downto 0);
data16      : in std_logic_vector(31 downto 0);
data17       : in std_logic_vector(31 downto 0);
data18       : in std_logic_vector(31 downto 0);
data19       : in std_logic_vector(31 downto 0);
data20       : in std_logic_vector(31 downto 0);
data21       : in std_logic_vector(31 downto 0);
data22       : in std_logic_vector(31 downto 0);
data23       : in std_logic_vector(31 downto 0);
data24       : in std_logic_vector(31 downto 0);
data25       : in std_logic_vector(31 downto 0);
data26       : in std_logic_vector(31 downto 0);
data27       : in std_logic_vector(31 downto 0);
data28       : in std_logic_vector(31 downto 0);
data29       : in std_logic_vector(31 downto 0);
data30       : in std_logic_vector(31 downto 0);
data31       : in std_logic_vector(31 downto 0);
sel       : in std_logic_vector(4 downto 0);
       output    : out std_logic_vector(31 downto 0));

end mux_32;

architecture dataflow of mux_32 is


begin

output <= data0 when sel = "00000" else 
data1 when sel = "00001" else 
data2 when sel = "00010" else 
data3 when sel = "00011" else 
data4 when sel = "00100" else 
data5 when sel = "00101" else 
data6 when sel = "00110" else 
data7 when sel = "00111" else 
data8 when sel = "01000" else
data9 when sel = "01001" else
data10 when sel = "01010" else
data11 when sel = "01011" else
data12 when sel = "01100" else
data13 when sel = "01101" else
data14 when sel = "01110" else
data15 when sel = "01111" else
data16 when sel = "10000" else
data17 when sel = "10001" else
data18 when sel = "10010" else
data19 when sel = "10011" else
data20 when sel = "10100" else
data21 when sel = "10101" else
data22 when sel = "10110" else
data23 when sel = "10111" else
data24 when sel = "11000" else
data25 when sel = "11001" else
data26 when sel = "11010" else
data27 when sel = "11011" else
data28 when sel = "11100" else
data29 when sel = "11101" else
data30 when sel = "11110" else
data31 when sel = "11111";

end dataflow;