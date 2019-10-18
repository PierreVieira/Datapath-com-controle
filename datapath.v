module datapath(clock, reset);
	input reset, clock;
	
	//Bloco PC onde começa o caminho de dados
	wire [31:0]saida_instrucao;
	PC BLOCO_0(saida_ultimo_mux, saida_instrucao, clock, reset);
	
	//add depois do PC
	wire [31:0]saida_addPc;
	somador BLOCO_1(saida_instrucao, 32'b00000000000000000000000000000100, saida_addPc);
	
	//Bloco que divide a instrução do PC
	wire[31:0]saida_adress;
	instruction_memory BLOCO_2(saida_instrucao, saida_adress);
	
	// Mux entre instruction memory e banco de registradores
	wire [4:0] saida_mux_antBlocoReg;
	mux2_1 BLOCO_4(saida_adress[20:16], saida_adress[15:11],RegDst, saida_mux_antBlocoReg);
	
	//Banco de Registradores
	wire[31:0] Data1, Data2;
	registers BLOCO_3 (saida_adress[25:21], saida_adress[20:16], saida_mux_antBlocoReg, saida_mux_data_memory, Regwrite, Data1, Data2 , clock );
	
	//Extende o sinal da instrução
	wire [31:0]saida_extensor;
	extensor BLOCO_5(saida_adress[15:0], saida_extensor);
	
	//Controle Geral !!!!!
	wire RegWrite, Jump, ALUsrc, MemWrite, MemToReg, MemRead, Branch, RegDst;
	wire [1:0] ALUop;
	controle BLOCO_6(saida_adress[31:26], RegWrite, Jump, ALUsrc, MemWrite, MemToReg, MemRead, Branch, RegDst, ALUop);
	
	//Mux que fica entre o banco de registradores e o ALU que tem o Zero
	wire [31:0]saida_mux_DepBlocoReg;
	mux2_1 BLOCO_7(Data2, saida_extensor, ALusrc, saida_mux_DepBlocoReg);
	
	//Bloco Alu Control
	wire [3:0]saida_ALU_control;
	AluControl BLOCO_8(ALUop, saida_adress[5:0], saida_ALU_control);
	
	//Bloco da ALU normal que tem o zero
	wire [31:0]saida_alu_result;
	wire zero;
	ula BLOCO_9(saida_ALU_control, Data1, saida_mux_DepBlocoReg, saida_alu_result,zero);
	
	//data memory
	wire [31:0]saida_Read_data;
	data_memory BLOCO_10(saida_alu_result, Data2, MemWrite, clock, MemRead );
	
	//Mux depois do data memory
	wire [31:0]saida_mux_data_memory;
	mux2_1 BLOCO_11(saida_Read_data, saida_alu_result, MemToReg, saida_mux_data_memory);
	
	// AND
	wire AND = Branch & zero;
	
	//Primeiro shift 
	wire [31:0]saida_shitf_Primeiro;
	shift_left2 BLOCO_12(saida_adress[25:0], saida_shitf_Primeiro);
	
	//Segundo shifit
	wire [31:0]saida_shitf_Segundo;
	shift_left2 BLOCO_13(saida_extensor, saida_shitf_Segundo);
	
	//ALU result depois do segundo shift 
	wire [31:0]saida_add_Alu_result;
	somador BLOCO_14(saida_addPc, saida_shitf_Segundo, saida_add_Alu_result);
	
	//penultimo mux superior
	wire [31:0]saida_penult_mux;
	mux2_1 BLOCO_15(saida_addPc, saida_add_Alu_result, AND, saida_penult_mux);
	
	//Último mux superior
	wire [31:0] saida_ultimo_mux;
	mux2_1 BLOCO_16(saida_shitf_Primeiro, saida_penult_mux, Jump, saida_ultimo_mux);
	
	endmodule 