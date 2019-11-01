module datapath(clock, reset);
	input reset, clock;
	
	//wire [31:0]saida_mux_data_memory;
	
	wire [4:0]saida_mux_1;
	wire [3:0]saida_alu_control;
	wire [31:0]saida_instrucao;
	wire [1:0] alu_Op;
	wire regDst, jump, branch, mem_Write, aluSrc, regWrite, memRead;
	//controle(entrada,RegWrite,Jump,ALUsrc,MemWrite,MemToReg,MemRead,Branch,RegDst,ALUop);
	controle BLOCO_CONTROLE(saida_instrucao[31:26], regWrite, jump, aluSrc, memWrite, memToReg, mem_Read, branch, regDst, alu_Op);
	
	
	wire [31:0]saida_PC, saida_mux_5;
	//PC(entrada_instrucao, saida_instrucao, clock, reset);
	PC BLOCO_PC(saida_mux_5, saida_PC, clock, reset);
	
	//instruction_memory(input [4:0] readAddress,output [31:0] instruction);
	instruction_memory BLOCO_Inst(saida_PC[6:2], saida_instrucao);
	
	wire [31:0]saida_add_1;
	//somador(a, b, s);
	somador BLOCO_ADD_1(saida_PC, 4, saida_add_1);
	
	wire [31:0]saida_mux_3;
	wire[31:0] data1, data2;
	//registers (Read1, Read2, WriteReg, WriteData, RegWrite, Data1, Data2, clock);
	registers BLOCO_REG(saida_instrucao[25:21], saida_instrucao[20:16], saida_mux_1, saida_mux_3, regWrite, data1, data2, clock);
	
	
	//mux2_1(a, b, control, S);
	mux2_1 BLOCO_MUX_1({27'b0, saida_instrucao[20:16]}, {27'b0, saida_instrucao[15:11]}, regDst, saida_mux_1);
	
	wire [31:0]saida_extensor;
	//extensor(input [15:0]entrada, output [31:0]saida);
	extensor BLOCO_EXT(saida_instrucao[15:0], saida_extensor);
	
	wire [31:0]saida_mux_2;
	mux2_1 BLOCO_MUX_2( data2, saida_extensor, aluSrc, saida_mux_2);
	
	wire [31:0]saida_alu_result;
	wire saida_zero;
	//ula(ALUctl, A, B, ALUOut, Zero);
	ula BLOCO_ULA(saida_alu_control, data1, saida_mux_2, saida_alu_result, saida_zero);
	
	//AluControl(ALUOP,instruction,saida);
	AluControl BLOCO_ALU_CONTROL(alu_Op, saida_instrucao[5:0], saida_alu_control);
	
	wire [31:0]saida_data_memory;
	//data_memory (addr, data, wr_en, read_en, Clock, q);
	data_memory BLOCO_DAT_MEMORY(saida_alu_result, data2, mem_Write, mem_Read, clock, saida_data_memory);
	
	
	//mux2_1(a, b, control, S);
	mux2_1 BLOCO_MUX_3( saida_alu_result, saida_data_memory, memToReg, saida_mux_3);
	//assign saida_mux_3 = (mem_To_Reg)? saida_data_memory : saida_alu_result;//teste 
	//assign saida_mux_3 = saida_alu_result;

	wire [27:0]saida_shitf_left_1;
	//shift_left2(entrada, saida);
	shift_left2 BLOCO_SHITF_1(saida_instrucao[25:0], saida_shitf_left_1);
	
	wire [31:0]jump_adr;
	assign jump_adr = {saida_add_1[31:28], saida_shitf_left_1};
	
	
	wire [31:0]saida_shitf_left_2;
	//shift_left2(entrada, saida);
	shift_left2 BLOCO_SHITF_2(saida_extensor, saida_shitf_left_2);
	
	
	wire [31:0]saida_add_2;
	//somador(a, b, s);
	somador BLOCO_ADD_2(saida_add_1, saida_shitf_left_2, saida_add_2);
	
	//AND
	wire saida_and;
	assign saida_and = branch & saida_zero;
	
	wire [31:0]saida_mux_4;
	//mux2_1(a, b, control, S);
	mux2_1 BLOCO_MUX_4(saida_add_1, saida_add_2, saida_and, saida_mux_4);
	
	//mux2_1(a, b, control, S);
	mux2_1 BLOCO_MUC_5(saida_mux_4, jump_adr, jump, saida_mux_5);
	
	
	
	//mem_Read foi usado como saida do data memoru (PODE DAR MERDA AQUIII !!!!!!!!!!!!!)
	
	endmodule 
