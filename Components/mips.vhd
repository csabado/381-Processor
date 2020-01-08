library IEEE;
use IEEE.std_logic_1164.all;

entity mips is
  port(clk        : in std_logic;     -- Clock input
       rst        : in std_logic;     -- Reset input
       wr         : in std_logic;     -- Write enable input
       selRD      : in std_logic_vector(4 downto 0);
       selRS      : in std_logic_vector(4 downto 0);
       selRT      : in std_logic_vector(4 downto 0);
       dataW      : in std_logic_vector(31 downto 0); 
       dataS      : out std_logic_vector(31 downto 0); 
       dataT      : out std_logic_vector(31 downto 0);
       reg_2	  : out std_logic_vector(31 downto 0));
end mips;

architecture structure of mips is


signal enables : std_logic_vector(31 downto 0);
signal read_data0,read_data1,read_data2,read_data3,read_data4,read_data5,read_data6,read_data7,read_data8,read_data9,read_data10,read_data11,
read_data12,read_data13,read_data14,read_data15,read_data16,read_data17,read_data18,read_data19,read_data20,read_data21,read_data22,read_data23,read_data24,
read_data25,read_data26,read_data27,read_data28,read_data29,read_data30,read_data31 : std_logic_vector(31 downto 0);

component decoder_5_32 is

  port( sel       : in std_logic_vector(4 downto 0);
	wr	 : in std_logic;
        output   : out std_logic_vector(31 downto 0));
end component;


component register_struct
  port(clk        : in std_logic;     -- Clock input
       rst        : in std_logic;     -- Reset input
       wr         : in std_logic;     -- Write enable input
       data       : in std_logic_vector(31 downto 0);     -- Data value input
       output     : out std_logic_vector(31 downto 0));
end component;

component mux_32 is

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
data10      : in std_logic_vector(31 downto 0);
data11      : in std_logic_vector(31 downto 0);
data12      : in std_logic_vector(31 downto 0);
data13      : in std_logic_vector(31 downto 0);
data14      : in std_logic_vector(31 downto 0);
data15      : in std_logic_vector(31 downto 0);
data16      : in std_logic_vector(31 downto 0);
data17      : in std_logic_vector(31 downto 0);
data18      : in std_logic_vector(31 downto 0);
data19      : in std_logic_vector(31 downto 0);
data20      : in std_logic_vector(31 downto 0);
data21      : in std_logic_vector(31 downto 0);
data22      : in std_logic_vector(31 downto 0);
data23      : in std_logic_vector(31 downto 0);
data24      : in std_logic_vector(31 downto 0);
data25      : in std_logic_vector(31 downto 0);
data26      : in std_logic_vector(31 downto 0);
data27      : in std_logic_vector(31 downto 0);
data28      : in std_logic_vector(31 downto 0);
data29      : in std_logic_vector(31 downto 0);
data30      : in std_logic_vector(31 downto 0);
data31      : in std_logic_vector(31 downto 0);
sel         : in std_logic_vector(4 downto 0);
output      : out std_logic_vector(31 downto 0));

end component;
 
begin

decoder_i: decoder_5_32
port map(sel => selRD,
	 wr  => wr,
	 output => enables);



register_struct_0: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(0),
       data => dataW,
       output => read_data0);

register_struct_1: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(1),
       data => dataW,
       output => read_data1);

register_struct_2: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(2),
       data => dataW,
       output => read_data2);

register_struct_3: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(3),
       data => dataW,
       output => read_data3);

register_struct_4: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(4),
       data => dataW,
       output => read_data4);

register_struct_5: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(5),
       data => dataW,
       output => read_data5);

register_struct_6: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(6),
       data => dataW,
       output => read_data6);

register_struct_7: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(7),
       data => dataW,
       output => read_data7);

register_struct_8: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(8),
       data => dataW,
       output => read_data8);

register_struct_9: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(9),
       data => dataW,
       output => read_data9);

register_struct_10: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(10),
       data => dataW,
       output => read_data10);

register_struct_11: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(11),
       data => dataW,
       output => read_data11);

register_struct_12: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(12),
       data => dataW,
       output => read_data12);

register_struct_13: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(13),
       data => dataW,
       output => read_data13);

register_struct_14: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(14),
       data => dataW,
       output => read_data14);

register_struct_15: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(15),
       data => dataW,
       output => read_data15);

register_struct_16: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(16),
       data => dataW,
       output => read_data16);

register_struct_17: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(17),
       data => dataW,
       output => read_data17);

register_struct_18: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(18),
       data => dataW,
       output => read_data18);

register_struct_19: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(19),
       data => dataW,
       output => read_data19);

register_struct_20: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(20),
       data => dataW,
       output => read_data20);

register_struct_21: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(21),
       data => dataW,
       output => read_data21);

register_struct_22: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(22),
       data => dataW,
       output => read_data22);

register_struct_23: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(23),
       data => dataW,
       output => read_data23);

register_struct_24: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(24),
       data => dataW,
       output => read_data24);

register_struct_25: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(25),
       data => dataW,
       output => read_data25);

register_struct_26: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(26),
       data => dataW,
       output => read_data26);

register_struct_27: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(27),
       data => dataW,
       output => read_data27);

register_struct_28: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(28),
       data => dataW,
       output => read_data28);

register_struct_29: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(29),
       data => dataW,
       output => read_data29);

register_struct_30: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(30),
       data => dataW,
       output => read_data30);

register_struct_31: register_struct
port map(clk => clk,
       rst => rst,
       wr => enables(31),
       data => dataW,
       output => read_data31);

mux_rs:mux_32
port map(data0 =>read_data0,
data1 =>read_data1,
data2 =>read_data2,
data3 =>read_data3,
data4 =>read_data4,
data5 =>read_data5,
data6 =>read_data6,
data7 =>read_data7,
data8 =>read_data8,
data9 =>read_data9,
data10 =>read_data10,
data11 =>read_data11,
data12 =>read_data12,
data13 =>read_data13,
data14 =>read_data14,
data15 =>read_data15,
data16 =>read_data16,
data17 =>read_data17,
data18 =>read_data18,
data19 =>read_data19,
data20 =>read_data20,
data21 =>read_data21,
data22 =>read_data22,
data23 =>read_data23,
data24 =>read_data24,
data25 =>read_data25,
data26 =>read_data26,
data27 =>read_data27,
data28 =>read_data28,
data29 =>read_data29,
data30 =>read_data30,
data31 =>read_data31,
sel    =>selRS,
output =>dataS);

mux_rt:mux_32
port map(data0 =>read_data0,
data1 =>read_data1,
data2 =>read_data2,
data3 =>read_data3,
data4 =>read_data4,
data5 =>read_data5,
data6 =>read_data6,
data7 =>read_data7,
data8 =>read_data8,
data9 =>read_data9,
data10 =>read_data10,
data11 =>read_data11,
data12 =>read_data12,
data13 =>read_data13,
data14 =>read_data14,
data15 =>read_data15,
data16 =>read_data16,
data17 =>read_data17,
data18 =>read_data18,
data19 =>read_data19,
data20 =>read_data20,
data21 =>read_data21,
data22 =>read_data22,
data23 =>read_data23,
data24 =>read_data24,
data25 =>read_data25,
data26 =>read_data26,
data27 =>read_data27,
data28 =>read_data28,
data29 =>read_data29,
data30 =>read_data30,
data31 =>read_data31,
sel    =>selRT,
output =>dataT);
  
reg_2<=read_data2;
end structure;