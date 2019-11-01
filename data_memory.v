module data_memory (addr, data, wr_en, read_en, Clock, q);
  input [31:0] addr; 
  input [31:0] data;
  input wr_en, Clock, read_en;
  output [31:0] q;

  reg [31:0] Mem [0:31];

  integer i;
  
  initial begin
    for(i = 0; i < 32;i = i+1)
      Mem[i] = 32'b0;
  end

  assign q = (read_en)? Mem[addr]:32'b0;

  always @(posedge Clock)
    begin
      if (wr_en) 
		Mem[addr] <= data;
    end
endmodule 
