library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shifter is
port( 	a	: in STD_LOGIC_VECTOR (31 downto 0);
	shamt	: in STD_LOGIC_VECTOR(4 downto 0);
	sel	: in STD_LOGIC_VECTOR(3 downto 0);
	c	: out STD_LOGIC_VECTOR (31 downto 0));
end shifter;

architecture mixed of shifter is


signal shift_ra,shift_ll,shift_rl,z,o,ar : STD_LOGIC_VECTOR (31 downto 0);

begin

z<="00000000000000000000000000000000";
o<="11111111111111111111111111111111";
ar<=o when a(31)='1' else
z;
--sra
with shamt select
shift_ra <=ar(30 downto 0)& a(31) when "11111",
ar(29 downto 0)& a(31 downto 30) when "11110",
ar(28 downto 0)& a(31 downto 29) when "11101",
ar(27 downto 0)& a(31 downto 28) when "11100",
ar(26 downto 0)& a(31 downto 27) when "11011",
ar(25 downto 0)& a(31 downto 26) when "11010",
ar(24 downto 0)& a(31 downto 25) when "11001",
ar(23 downto 0)& a(31 downto 24) when "11000",
ar(22 downto 0)& a(31 downto 23) when "10111",
ar(21 downto 0)& a(31 downto 22) when "10110",
ar(20 downto 0)& a(31 downto 21) when "10101",
ar(19 downto 0)& a(31 downto 20) when "10100",
ar(18 downto 0)& a(31 downto 19) when "10011",
ar(17 downto 0)& a(31 downto 18) when "10010",
ar(16 downto 0)& a(31 downto 17) when "10001",
ar(15 downto 0)& a(31 downto 16) when "10000",
ar(14 downto 0)& a(31 downto 15) when "01111",
ar(13 downto 0)& a(31 downto 14) when "01110",
ar(12 downto 0)& a(31 downto 13) when "01101",
ar(11 downto 0)& a(31 downto 12) when "01100",
ar(10 downto 0)& a(31 downto 11) when "01011",
ar(9 downto 0)& a(31 downto 10) when "01010",
ar(8 downto 0)& a(31 downto 9) when "01001",
ar(7 downto 0)& a(31 downto 8) when "01000",
ar(6 downto 0)& a(31 downto 7) when "00111",
ar(5 downto 0)& a(31 downto 6) when "00110",
ar(4 downto 0)& a(31 downto 5) when "00101",
ar(3 downto 0)& a(31 downto 4) when "00100",
ar(2 downto 0)& a(31 downto 3) when "00011",
ar(1 downto 0)& a(31 downto 2) when "00010",
ar(0)& a(31 downto 1) when "00001",
a when others;

--sll
with shamt select
shift_ll <= a (31 downto 0) when "00000",
a(30 downto 0)& z(31) when "00001",
a(29 downto 0)& z(31 downto 30) when "00010",
a(28 downto 0)& z(31 downto 29) when "00011",
a(27 downto 0)& z(31 downto 28) when "00100",
a(26 downto 0)& z(31 downto 27) when "00101",
a(25 downto 0)& z(31 downto 26) when "00110",
a(24 downto 0)& z(31 downto 25) when "00111",
a(23 downto 0)& z(31 downto 24) when "01000",
a(22 downto 0)& z(31 downto 23) when "01001",
a(21 downto 0)& z(31 downto 22) when "01010",
a(20 downto 0)& z(31 downto 21) when "01011",
a(19 downto 0)& z(31 downto 20) when "01100",
a(18 downto 0)& z(31 downto 19) when "01101",
a(17 downto 0)& z(31 downto 18) when "01110",
a(16 downto 0)& z(31 downto 17) when "01111",
a(15 downto 0)& z(31 downto 16) when "10000",
a(14 downto 0)& z(31 downto 15) when "10001",
a(13 downto 0)& z(31 downto 14) when "10010",
a(12 downto 0)& z(31 downto 13) when "10011",
a(11 downto 0)& z(31 downto 12) when "10100",
a(10 downto 0)& z(31 downto 11) when "10101",
a(9 downto 0)& z(31 downto 10) when "10110",
a(8 downto 0)& z(31 downto 9) when "10111",
a(7 downto 0)& z(31 downto 8) when "11000",
a(6 downto 0)& z(31 downto 7) when "11001",
a(5 downto 0)& z(31 downto 6) when "11010",
a(4 downto 0)& z(31 downto 5) when "11011",
a(3 downto 0)& z(31 downto 4) when "11100",
a(2 downto 0)& z(31 downto 3) when "11101",
a(1 downto 0)& z(31 downto 2) when "11110",
a(0)& z(31 downto 1) when "11111",
a when others;

--srl
with shamt select
shift_rl <=z(30 downto 0)& a(31) when "11111",
z(29 downto 0)& a(31 downto 30) when "11110",
z(28 downto 0)& a(31 downto 29) when "11101",
z(27 downto 0)& a(31 downto 28) when "11100",
z(26 downto 0)& a(31 downto 27) when "11011",
z(25 downto 0)& a(31 downto 26) when "11010",
z(24 downto 0)& a(31 downto 25) when "11001",
z(23 downto 0)& a(31 downto 24) when "11000",
z(22 downto 0)& a(31 downto 23) when "10111",
z(21 downto 0)& a(31 downto 22) when "10110",
z(20 downto 0)& a(31 downto 21) when "10101",
z(19 downto 0)& a(31 downto 20) when "10100",
z(18 downto 0)& a(31 downto 19) when "10011",
z(17 downto 0)& a(31 downto 18) when "10010",
z(16 downto 0)& a(31 downto 17) when "10001",
z(15 downto 0)& a(31 downto 16) when "10000",
z(14 downto 0)& a(31 downto 15) when "01111",
z(13 downto 0)& a(31 downto 14) when "01110",
z(12 downto 0)& a(31 downto 13) when "01101",
z(11 downto 0)& a(31 downto 12) when "01100",
z(10 downto 0)& a(31 downto 11) when "01011",
z(9 downto 0)& a(31 downto 10) when "01010",
z(8 downto 0)& a(31 downto 9) when "01001",
z(7 downto 0)& a(31 downto 8) when "01000",
z(6 downto 0)& a(31 downto 7) when "00111",
z(5 downto 0)& a(31 downto 6) when "00110",
z(4 downto 0)& a(31 downto 5) when "00101",
z(3 downto 0)& a(31 downto 4) when "00100",
z(2 downto 0)& a(31 downto 3) when "00011",
z(1 downto 0)& a(31 downto 2) when "00010",
z(0)& a(31 downto 1) when "00001",
a when others;


c<= shift_ra when sel(3 downto 0)="1011" or sel(3 downto 0)="1111" else
shift_ll when sel(3 downto 0)="1000" or sel(3 downto 0)="1100" or sel(3 downto 0)="1110" else
shift_rl when sel(3 downto 0)="1001" or sel(3 downto 0)="1101" else
a;

end mixed;


