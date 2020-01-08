library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity sign_zero_extender is
  port( i          : in std_logic_vector(15 downto 0); 
	unsign	   : in std_logic;
        o          : out std_logic_vector(31 downto 0));
end sign_zero_extender;

architecture structure of sign_zero_extender is

component sign_extension is
 port(i          : in std_logic_vector(15 downto 0); 
       o          : out std_logic_vector(31 downto 0));
 end component;

component zero_extension is
 port(i          : in std_logic_vector(15 downto 0); 
       o          : out std_logic_vector(31 downto 0));
 end component;

component mux_struct
generic(N : integer :=32);
   port(y0          : in std_logic_vector(N-1 downto 0);
	y1          : in std_logic_vector(N-1 downto 0);  
	sel         : in std_logic;
	z           : out std_logic_vector(N-1 downto 0));
 end component;

signal zero_i,sign_i: std_logic_vector(31 downto 0);
signal neg_and_signed: std_logic;

begin

	neg_and_signed<= (i(15) and (not unsign));
	sign:sign_extension
	port map(i=>i,
		o=>sign_i);
	zero:zero_extension
	port map(i=>i,
		o=>zero_i);

	mux_i: mux_struct 
    	port map(y0  => zero_i,
  	     y1  => sign_i,
	     sel  => neg_and_signed,
	     z   => o);
  
end structure; 