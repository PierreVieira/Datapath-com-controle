module extensor(input [15:0]entrada, output [31:0]saida); 
	assign saida = {{16{entrada[15]}}, entrada};
endmodule 
