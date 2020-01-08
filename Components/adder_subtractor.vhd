library IEEE;
use IEEE.std_logic_1164.all;

entity adder_subtractor is
  generic(N : integer :=32);
   port(a          : in std_logic_vector(N-1 downto 0);
	b          : in std_logic_vector(N-1 downto 0);
	ctrl       : in std_logic;  
	sum        : out std_logic_vector(N-1 downto 0);
	co         : out std_logic);

end adder_subtractor;

architecture structure of adder_subtractor is

component adder_struct
  generic(N : integer :=32);
   port(y0          : in std_logic_vector(N-1 downto 0);
	y1          : in std_logic_vector(N-1 downto 0);
	ci          : in std_logic;  
	co          : out std_logic;
	z           : out std_logic_vector(N-1 downto 0));
end component;

component mux_struct
generic(N : integer :=32);
   port(y0          : in std_logic_vector(N-1 downto 0);
	y1          : in std_logic_vector(N-1 downto 0);  
	sel         : in std_logic;
	z           : out std_logic_vector(N-1 downto 0));
 end component;

component invg_struct
generic(N : integer :=32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));
end component;

signal fa_z,carry,b_i,fs_z,fs_c,output : std_logic_vector(31 downto 0);

begin


  adder_i: adder_struct 
    port map(y0  => a,
  	     y1  => b,
	     ci  => ctrl,
	     co  => co,
	     z   => fa_z);

  invg_i: invg_struct 
    port map(i_A  => b,
  	     o_F  => b_i);

  adder_2: adder_struct 
    port map(y0  => "00000000000000000000000000000000",
  	     y1  => b_i,
	     ci  => ctrl,
	     co  => co,
	     z   => fs_z);

    adder_3: adder_struct 
    port map(y0  => a,
  	     y1  => fs_z,
	     ci  => '0',
	     co  => co,
	     z   => output);

   mux_i: mux_struct 
    port map(y0  => fa_z,
  	     y1  => output,
	     sel  => ctrl,
	     z   => sum);


  
end structure;