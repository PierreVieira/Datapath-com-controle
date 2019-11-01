module controle(entrada,RegWrite,Jump,ALUsrc,MemWrite,MemToReg,MemRead,Branch,RegDst,ALUop);

	input[5:0] entrada;
	output reg [1:0] ALUop;
	output reg RegWrite,Jump,ALUsrc,MemWrite,MemToReg,MemRead,Branch,RegDst;

always@(*)begin
	
	case(entrada)
	//TIPO R
	6'b000000 : begin
						Jump 		<= 0;
						RegWrite <= 1;
						ALUsrc   <= 0;
						MemWrite <= 0;
						ALUop    = 2'b10;
						MemToReg <= 0;
						MemRead  <= 0;
						Branch   <= 0;
						RegDst   <= 1;
					end
	// LW
	6'b100011 :	begin		
						Jump 		<= 0;
						RegWrite <= 1;
						ALUsrc   <= 1;
						MemWrite <= 0;
						ALUop    <= 2'b00;
						MemToReg <= 1;
						MemRead  <= 1;
						Branch   <= 0;
						RegDst 	<= 0;
					end
	//SW	
	6'b101011 : begin
						Jump 		<= 0;
						RegWrite <= 0;
						ALUsrc   <= 1;
						MemWrite <= 1; 
						ALUop    <= 2'b00;
						MemToReg <= 0; //X 
						MemRead  <= 0;
						Branch   <= 0;
						RegDst 	<= 0; //X 
					end
	//BEQ				
	6'b000100 : begin
						Jump 		<= 0;
						RegWrite <= 0;
						ALUsrc   <= 0;
						MemWrite <= 0;
						ALUop    <= 2'b01;
						MemToReg <= 0; //X 
						MemRead  <= 0;
						Branch   <= 1;
						RegDst 	<= 0; //X	
					end
					
					
	//J				
	6'b000010 : begin
						Jump 		<= 1;
						RegWrite <= 0;
						ALUsrc   <= 0;
						MemWrite <= 0;
						ALUop    <= 2'b00;
						MemToReg <= 0; 
						MemRead  <= 0;
						Branch   <= 0;
						RegDst 	<= 0;	
					end
				 			
	
				 			
	//ADDI				
	6'b001000 : begin
						Jump 		<= 0;
						RegWrite <= 1;
						ALUsrc   <= 1;
						MemWrite <= 0;
						ALUop    <= 2'b00;
						MemToReg <= 0; 
						MemRead  <= 0;
						Branch   <= 0;
						RegDst 	<= 0;	
					end
				 			
	
	
	
	endcase
end
endmodule 
