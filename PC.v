module PC(entrada_instrucao, saida_instrucao, clock, reset);
	input [31:0]entrada_instrucao;
	input clock, reset;
	output reg [31:0]saida_instrucao;
	
	always@(posedge clock)begin
	if(reset)
	saida_instrucao <= 32'b0;
	else 
	 
	saida_instrucao <= entrada_instrucao;
	end

	endmodule 
