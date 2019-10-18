module instruction_memory(input [4:0] readAddress,output [31:0] instruction);
  reg [31:0] instructions [31:0];
  
  initial begin
    instructions[0] = 32'h20110004;// addi $s1 ,$0, 4
    instructions[1] = 32'h20120008;// addi $s2, $0, 8
    instructions[2] = 32'h02329820;// add $s3, $s1, $s2

  end
    
  assign instruction = instructions[readAddress];
  
endmodule