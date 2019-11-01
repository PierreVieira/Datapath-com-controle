module instruction_memory(input [4:0] readAddress,output [31:0] instruction);
  reg [31:0] instructions [31:0];
  
  initial begin
    instructions[0] = 32'b00000010001100101001100000100000;// add $s3, $s1, $s2
	 //instructions[0] = 32'b00100000000100010000000000001000;// add $s1, $0, 8

  end
    
  assign instruction = instructions[readAddress];
  
endmodule
