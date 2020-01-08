library IEEE;
use IEEE.std_logic_1164.all;

entity control is
port(	op 	: in std_logic_vector(5 downto 0);
	func	: in std_logic_vector(5 downto 0);
	alusrc 	: out std_logic;
	aluctrl : out std_logic_vector(3 downto 0);
	memtoreg: out std_logic;
	dmemwr	: out std_logic;
	regwr	: out std_logic;
	regdst	: out std_logic;
	unsign	: out std_logic;
	jump	: out std_logic;
	branch	: out std_logic;
	beq	: out std_logic;
	jal	: out std_logic;
	jr	: out std_logic);
end control;

architecture dataflow of control is

begin

alusrc <= '1' when  op="001000" or op="001001" or op="001100" or op="001111" or op="100011" or op="001110" or op="001101" or op="001010" or op="001011" or op="101011"  else
'0';
--'1' when op="001110" else

aluctrl<="0001" when (op="000000"and(func="100010" or func="100011"))or op="000100"or op="000101" else
"0010" when op="001010" or op="001011" or(op="000000"and (func="101010"or func="101011"))else
"0011" when op="001101" or(op="000000" and func="100101")else
"0100" when op="001100" or(func="100100" and op="000000") else--I was here
"0101" when op="001110" or(op="000000" and func="100110") else
"0111" when op="000000" and func="100111" else
"1000" when op="000000" and func="000000" else
"1001" when op="000000" and func="000010" else
--"1010" when op="000000" and func="000000" else
"1011" when op="000000" and func="000011" else
"1100" when op="000000" and func="000100" else
"1101" when op="000000" and func="000110" else
"1110" when op="001111"else
"1111" when op="000000" and func="000111" else
"0000";

memtoreg<='1' when op="100011" else
'0';

dmemwr<='1' when op="101011" else
'0';

--regwr<='0' when op="101011" or op="000010" or op="000011" or op="000100" or op="000101" or (op="000000" and func="001000")else
--'1';
regwr<='1' when op="001000" or op="001001" or op="001100" or op="001111" or op="100011" or op="001110" or op="001101" or op="001010" or op="001011" or op="000011"
or (op="000000" and (func="100000" or func="100001" or func="100100" or func="100111" or func="100110" or func="100101" or func="101010" or func="101011" or func="000000" 
or func="000010" or func="000011" or func="000100" or func="000110" or func="000111" or func="100010" or func="100011")) else
'0';

regdst<='1' when op="001000" or op="001001" or op="001100" or op="001111" or op="100011" or op="001110" or op="001101" or op="001010" or op="001011" else
'0';

unsign<='1' when op="001001" or op="001011" or (op="000000" and (func="100001" or func="101011" or func="100011")) else
'0';

jump<='1' when op="000010" or op="000011" or (op="000000"and func="001000")else
'0';

branch<='1' when op="000100" or op="000101" else
'0';

beq<='1' when op="000100" else
'0';

jal<='1' when op="000011" else
'0';

jr<='1' when op="000000" and func="001000" else
'0';


end dataflow;
	