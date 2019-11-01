module AluControl(ALUOP,instruction,saida);

input [1:0] ALUOP;
input [5:0] instruction;
output reg [3:0]saida;

wire [7:0]aux ={ALUOP,instruction};

always@(*)begin

	case(aux)
		8'b10100000 : saida = 4'b0010; //add
		//8'b10100000 : saida = 4'b0010; adicionar addi
		8'b10100010 : saida = 4'b0110; //sub
		8'b10100100 : saida = 4'b0000; //and
		8'b10100101 : saida = 4'b0001; //or
		8'b10101010 : saida = 4'b0111; //slt
		//8'b00XXXXXX : saida = 4'b0010;
		//8'b01XXXXXX : saida = 4'b0110;

	
	endcase

	case(ALUOP)
		2'b00 : saida = 4'b0010;
		2'b01 : saida = 4'b0110;
	endcase


end

endmodule 
