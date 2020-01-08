-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

entity MIPS_Processor is
  generic(N : integer := 32);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal v0             : std_logic_vector(N-1 downto 0); -- TODO: should be assigned to the output of register 2, used to implement the halt SYSCALL
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. This case happens when the syscall instruction is observed and the V0 register is at 0x0000000A. This signal is active high and should only be asserted after the last register and memory writes before the syscall are guaranteed to be completed.

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

   component pc is
   port(clk        : in std_logic;     -- Clock input
        rst        : in std_logic;     -- Reset input
        wr         : in std_logic;     -- Write enable input
        data       : in std_logic_vector(31 downto 0);     -- Data value input
        output     : out std_logic_vector(31 downto 0));   -- Data value output

   end component;

   component adder_struct is
   generic(N : integer :=32);
   port(y0          : in std_logic_vector(N-1 downto 0);
	y1          : in std_logic_vector(N-1 downto 0);
	ci          : in std_logic;  
	co          : out std_logic;
	z           : out std_logic_vector(N-1 downto 0));

   end component;

   component ifid is
	port(clk        : in std_logic;
       rst        : in std_logic;
       stall      : in std_logic;
       instr      : in std_logic_vector(31 downto 0);
       pc         : in std_logic_vector(31 downto 0);
       instrO     : out std_logic_vector(31 downto 0);
       pcO        : out std_logic_vector(31 downto 0));

   end component;

   component control is
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
   end component;

  component branch_jump_handler is
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
   end component;

   component mips is
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

   end component;

  component idex is
  port(clk      	: in std_logic;
       	rst     	: in std_logic;
       	stall   	: in std_logic;
       	instr   	: in std_logic_vector(31 downto 0);
       	pc     		: in std_logic_vector(31 downto 0);
	alusrc 		: in std_logic;
	aluctrl 	: in std_logic_vector(3 downto 0);
	memtoreg	: in std_logic;
	dmemwr		: in std_logic;
	regwr		: in std_logic;
	regdst		: in std_logic;
	unsign		: in std_logic;
	jal		: in std_logic;
	imm		: in std_logic_vector(31 downto 0);
	rs		: in std_logic_vector(31 downto 0);
	rt		: in std_logic_vector(31 downto 0);
	instrO  	: out std_logic_vector(31 downto 0);
      	pcO     	: out std_logic_vector(31 downto 0);
       	alusrcO 	: out std_logic;
	aluctrlO 	: out std_logic_vector(3 downto 0);
	memtoregO	: out std_logic;
	dmemwrO		: out std_logic;
	regwrO		: out std_logic;
	regdstO		: out std_logic;
	unsignO		: out std_logic;
	jalO		: out std_logic;
	immO		: out std_logic_vector(31 downto 0);
	rsO		: out std_logic_vector(31 downto 0);
	rtO		: out std_logic_vector(31 downto 0));	

   end component;

   component alu is
  	port(sel         : in std_logic_vector(3 downto 0);
	a          : in std_logic_vector(31 downto 0);  
	b          : in std_logic_vector(31 downto 0);
	shamt	   : in std_logic_vector(4 downto 0);
	unsign	   : in std_logic;
	z          : out std_logic_vector(31 downto 0);
	co         : out std_logic;
	zero       : out std_logic;
	over       : out std_logic);

   end component;

   component exmem is
        port(clk      	: in std_logic;
       	rst     	: in std_logic;
       	stall   	: in std_logic;
       	instr   	: in std_logic_vector(31 downto 0);
       	pc     		: in std_logic_vector(31 downto 0);
	memtoreg	: in std_logic;
	dmemwr		: in std_logic;
	regwr		: in std_logic;
	regdst		: in std_logic;
	jal		: in std_logic;
	imm		: in std_logic_vector(31 downto 0);
	rs		: in std_logic_vector(31 downto 0);
	rt		: in std_logic_vector(31 downto 0);
	alu		: in std_logic_vector(31 downto 0);
	zero		: in std_logic;

	instrO  	: out std_logic_vector(31 downto 0);
      	pcO     	: out std_logic_vector(31 downto 0);
	memtoregO	: out std_logic;
	dmemwrO		: out std_logic;
	regwrO		: out std_logic;
	regdstO		: out std_logic;
	jalO		: out std_logic;
	immO		: out std_logic_vector(31 downto 0);
	rsO		: out std_logic_vector(31 downto 0);
	rtO		: out std_logic_vector(31 downto 0);
	aluO		: out std_logic_vector(31 downto 0);
	zeroO		: out std_logic);	

   end component;

   component sign_zero_extender is
  	port(   i          : in std_logic_vector(15 downto 0); 
		unsign	   : in std_logic;
       		o          : out std_logic_vector(31 downto 0));
   end component;

   component mux_dataflow is
   	port(   y0          : in std_logic_vector(N-1 downto 0);
		y1          : in std_logic_vector(N-1 downto 0);  
		sel         : in std_logic;
		z           : out std_logic_vector(N-1 downto 0));

   end component;

   component mux_struct_5 is
  	generic(N : integer :=5);
   	port(y0          : in std_logic_vector(N-1 downto 0);
	y1          : in std_logic_vector(N-1 downto 0);  
	sel         : in std_logic;
	z           : out std_logic_vector(N-1 downto 0));

   end component;

  component memwb is
        port(clk      	: in std_logic;
       	rst     	: in std_logic;
       	stall   	: in std_logic;
       	instr   	: in std_logic_vector(31 downto 0);
	pc     		: in std_logic_vector(31 downto 0);
	memtoreg	: in std_logic;
	regwr		: in std_logic;
	regdst		: in std_logic;
	jal		: in std_logic;
	imm		: in std_logic_vector(31 downto 0);
	alu		: in std_logic_vector(31 downto 0);
	memdata		: in std_logic_vector(31 downto 0);

	instrO  	: out std_logic_vector(31 downto 0);
	pcO     	: out std_logic_vector(31 downto 0);
	memtoregO	: out std_logic;
	regwrO		: out std_logic;
	regdstO		: out std_logic;
	jalO		: out std_logic;
	immO		: out std_logic_vector(31 downto 0);
	aluO		: out std_logic_vector(31 downto 0);
	memdataO	: out std_logic_vector(31 downto 0));	

 end component;

   

  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment

--controls
signal alusrc,memtoreg,regdst,unsign,jump,branch,beq,jal,jr,dmemwr,regwr : std_logic;
signal aluctrl: std_logic_vector(3 downto 0);

signal debug:std_logic;

--data
signal rsData,rtData,extendedImmediate,alu_b,next_instruction,next_instruction_jb,pc_plus4,rd_data : std_logic_vector(31 downto 0);
signal rd_write : std_logic_vector(4 downto 0);
signal co,co_pc,zero,over : std_logic;

--alu
signal alu_out : std_logic_vector(31 downto 0);


signal stall,flush : std_logic;
--ifid
signal instr_ifid,pc_ifid : std_logic_vector(31 downto 0);

--idex
signal instr_idex,pc_idex,imm_idex,rs_idex,rt_idex :std_logic_vector(31 downto 0);
signal aluctrl_idex :std_logic_vector(3 downto 0);
signal alusrc_idex,memtoreg_idex,dmemwr_idex,regwr_idex,regdst_idex,unsign_idex,jal_idex :std_logic;

--exmem
signal instr_exmem,pc_exmem,imm_exmem,rs_exmem,rt_exmem,alu_exmem : std_logic_vector(31 downto 0);
signal memtoreg_exmem,dmemwr_exmem,regwr_exmem,regdst_exmem,jal_exmem,zero_exmem : std_logic;

--memwb
signal alu_memwb,imm_memwb,instr_memwb,pc_memwb,memdata_memwb : std_logic_vector(31 downto 0);
signal rd_write_memwb : std_logic_vector(4 downto 0);
signal memtoreg_memwb,regdst_memwb,jal_memwb,regwr_memwb : std_logic;

begin

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;


  IMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  DMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);

  s_Halt <='1' when (instr_memwb(31 downto 26) = "000000") and (instr_memwb(5 downto 0) = "001100") and (v0 = "00000000000000000000000000001010") else '0';

  -- TODO: Implement the rest of your processor below this comment!

stall<='0';
flush<='0';

next_instruction<=next_instruction_jb when branch='1' or jump='1' else
pc_plus4;

p_c:pc
   port map(clk=>iCLK,
        rst=>iRST,
        wr=>'1',
        data=>next_instruction,
        output=>s_NextInstAddr);   -- Data value output

adder_4:adder_struct
   port map(y0=>pc_ifid, --s_NextInstAddr
	y1=>"00000000000000000000000000000100",
	ci=>'0',  
	co=>co_pc,
	z=>pc_plus4);

ifid_1:ifid
	port map(clk=>iCLK,
       	rst=>iRST,
       	stall=>stall,
       	instr=>s_Inst,
       	pc=>next_instruction,
       	instrO=>instr_ifid,
       	pcO=>pc_ifid);


registerfile:mips
	port map(clk=>iCLK,
       	rst=>iRST,
      	wr=>s_RegWr,
       	selRD=>s_RegWrAddr,
       	selRS=>instr_ifid(25 downto 21),
       	selRT=>instr_ifid(20 downto 16),
       	dataW=>s_RegWrData, 
       	dataS=>rsData,
       	dataT=>rtData,
	reg_2=>v0);

ctrl: control
	port map(op=>instr_ifid(31 downto 26),
	func=>instr_ifid(5 downto 0),
	alusrc=>alusrc,
	aluctrl=>aluctrl,
	memtoreg=>memtoreg,
	dmemwr=>dmemwr,
	regwr=>regwr,
	regdst=>regdst,
	unsign=>unsign,
	jump=>jump,
	branch=>branch,
	beq=>beq,
	jal=>jal,
	jr=>jr);


sign_extended:sign_zero_extender
	port map(i=>instr_ifid(15 downto 0),
		unsign=>unsign,
       		o=>extendedImmediate);

branch_handler: branch_jump_handler
	port map( branch=>branch,
	jump=>jump,
	jal=>jal,
	jr=>jr,
	beq=>beq,
	currPC=>pc_ifid,
	rs=>rsData,
	rt=>rtData,
	target=>extendedImmediate,
	jumpTarget=>instr_ifid(25 downto 0),
	pc=>next_instruction_jb);

idex_1:idex
  	port map(clk=>iCLK,
       	rst=>iRST,
       	stall=>stall,
       	instr=>instr_ifid,
       	pc=>pc_ifid,
	alusrc=>alusrc,
	aluctrl=>aluctrl,
	memtoreg=>memtoreg,
	dmemwr=>dmemwr,
	regwr=>regwr,
	regdst=>regdst,
	unsign=>unsign,
	jal=>jal,
	imm=>extendedImmediate,
	rs=>rsData,
	rt=>rtData,
	instrO=>instr_idex,
      	pcO=>pc_idex,
       	alusrcO=>alusrc_idex,
	aluctrlO=>aluctrl_idex,
	memtoregO=>memtoreg_idex,
	dmemwrO=>dmemwr_idex,
	regwrO=>regwr_idex,
	regdstO=>regdst_idex,
	unsignO=>unsign_idex,
	jalO=>jal_idex,
	immO=>imm_idex,
	rsO=>rs_idex,
	rtO=>rt_idex);

alu_mux:mux_dataflow
	port map(y0=>rt_idex,
		y1=>imm_idex, 
		sel=>alusrc_idex,
		z =>alu_b);

full_alu:alu
	port map(sel=>aluctrl_idex,
	a=>rs_idex,  
	b=>alu_b,
	shamt=>instr_idex(10 downto 6),
	unsign=>unsign_idex,
	z=>alu_out,
	co=>co,
	zero=>zero,
	over=>over);

oALUOut<=alu_out;

exmem_1:exmem
        port map(clk=>iCLK,
       	rst=>iRST,
       	stall=>stall,
       	instr=>instr_idex,
       	pc=>pc_idex,
	memtoreg=>memtoreg_idex,
	dmemwr=>dmemwr_idex,
	regwr=>regwr_idex,
	regdst=>regdst_idex,
	jal=>jal_idex,
	imm=>imm_idex,
	rs=>rs_idex,
	rt=>rt_idex,
	alu=>alu_out,
	zero=>zero,

	instrO=>instr_exmem,
      	pcO=>pc_exmem,
	memtoregO=>memtoreg_exmem,
	dmemwrO=>dmemwr_exmem,
	regwrO=>regwr_exmem,
	regdstO=>regdst_exmem,
	jalO=>jal_exmem,
	immO=>imm_exmem,
	rsO=>rs_exmem,
	rtO=>rt_exmem,
	aluO=>alu_exmem,
	zeroO=>zero_exmem);	

s_DMemData<=rt_exmem;
s_DMemAddr<=alu_exmem;
s_DMemWr<=dmemwr_exmem;

memwb_1:memwb
        port map(clk=>iCLK,
       	rst=>iRST,
       	stall=>stall,
       	instr=>instr_exmem,
	pc=>pc_exmem,
	memtoreg=>memtoreg_exmem,
	regwr=>regwr_exmem,
	regdst=>regdst_exmem,
	jal=>jal_exmem,
	imm=>imm_exmem,
	alu=>alu_exmem,
	memdata=>s_DMemOut,

	instrO=>instr_memwb,
	pcO=>pc_memwb,
	memtoregO=>memtoreg_memwb,
	regwrO=>regwr_memwb,
	regdstO=>regdst_memwb,
	jalO=>jal_memwb,
	immO=>imm_memwb,
	aluO=>alu_memwb,
	memdataO=>memdata_memwb);	


rd_mux:mux_dataflow
	port map(y0=>alu_memwb,
		y1=>memdata_memwb, 
		sel=>memtoreg_memwb,
		z =>rd_data);


write_mux:mux_struct_5
	port map(y0=>instr_memwb(15 downto 11),
		y1=>instr_memwb(20 downto 16), 
		sel=>regdst_memwb,
		z =>rd_write_memwb);

s_RegWrAddr<="11111" when jal_memwb='1' else
rd_write_memwb;

s_RegWrData<=pc_memwb when jal_memwb='1' else
rd_data;

debug<='1' when s_RegWrData=x"00000001" and s_RegWrAddr<=x"0D" else
'0';

s_RegWr<=regwr_memwb;

end structure;
