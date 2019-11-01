module registers (Read1, Read2, WriteReg, WriteData, RegWrite, Data1, Data2, clock);
	input [4:0] Read1, Read2, WriteReg; // os números dos registradores para leitura e escrita
	input [31:0] WriteData; // dados para escrever
	input RegWrite, // O controle de escrita
	clock; // o clock para acionar a escrita
	output [31:0] Data1, Data2; // os valores dos registradores lidos
	reg [31:0] RF [31:0]; // 32 registradores cada um com 32 bits
	initial begin
		RF[17] = 3'b011;
		RF[18] = 3'b010;
	end
	assign Data1 = RF[Read1];
	assign Data2 = RF[Read2];
	always @(posedge clock) begin
	if (RegWrite) 
		RF[WriteReg] <= WriteData;
	end
endmodule 
