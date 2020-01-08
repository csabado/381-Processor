library IEEE;
use IEEE.std_logic_1164.all;

entity branch_jump_handler is
  port( branch  : in std_logic;
	jump	: in std_logic;
	jal	: in std_logic;
	jr	: in std_logic;
	beq	: in std_logic;
	currPC	: in std_logic_vector(31 downto 0);
	rs	: in std_logic_vector(31 downto 0);
	rt	: in std_logic_vector(31 downto 0);
	target	: in std_logic_vector(31 downto 0);
	jumpTarget : in std_logic_vector(25 downto 0); 
	pc	: out std_logic_vector(31 downto 0));
end branch_jump_handler;

architecture mixed of branch_jump_handler is

component adder_struct is
  generic(N : integer :=32);
   port(y0          : in std_logic_vector(N-1 downto 0);
	y1          : in std_logic_vector(N-1 downto 0);
	ci          : in std_logic;  
	co          : out std_logic;
	z           : out std_logic_vector(N-1 downto 0));

end component;

signal  branchDst,branchPC,shiftedJump : std_logic_vector(31 downto 0);
--signal  shiftedJump : std_logic_vector(27 downto 0);
signal  co,zero : std_logic;

begin 

branchDst<=target(29 downto 0)&"00";

adder: adder_struct
   port map(y0=>currPC,
	y1=>branchDst,
	ci=>'0', 
	co=>co,
	z=>branchPC);

shiftedJump<= rs when jr='1' else
currPC(31 downto 28)&jumpTarget&"00";

zero<= '1' when rs=rt else
'0';

pc<=branchPC when branch='1' and ((beq='1' and zero='1')or(beq='0' and zero='0')) else
shiftedJump when jump='1'else 
currPC;

end mixed;

	