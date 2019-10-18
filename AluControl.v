module AluControl(ALUOP,instruction,saida);

input [1:0] ALUOP;
input [5:0] instruction;
output reg [3:0]saida;

wire [7:0]aux ={ALUOP,instruction};

always@(*)begin

	case(aux)
		8'b00xxxxxx : saida = 4'b0010;
		8'bx1xxxxxx : saida = 4'b0110;
		8'b1xxx0000 : saida = 4'b0010;
		8'b1xxx0010 : saida = 4'b0110;
		8'b1xxx0100 : saida = 4'b0000;
		8'b1xxx0101 : saida = 4'b0001;
		8'b1xxx1010 : saida = 4'b0111;
	
	endcase

end

endmodule 