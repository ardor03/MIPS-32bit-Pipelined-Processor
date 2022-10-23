`timescale 1ns/1ns
module testbench ();
reg clk;
reg [31:0]instruction;
reg [31:0] valueInput;
  reg flag1,flag2;
 
  reg [4:0] index;
  wire [4:0] RsD,RtD,RdD;
  wire [31:0] data1,data2,data2_temp,signImmD,PCbranchD;
  wire [31:0] PCReg;
  wire [3:0] ALUControlD;
  wire [1:0] ALUOp;
  wire hazardDetected,PCSrcD,equalD;
  wire [31:0] valueOutput;
   initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0,testbench);
        clk                  = 1;
        repeat(5000) #50 clk = ~clk;
    end
    assign instruction=32'b00000000010000110000100000100000;
    assign valueInput=32'd1;
    instructionDecode instructionDecode (clk,
                         instruction,
                         data1,
                         data2,
                         RsD,
                         RtD,
                         RdD,
                         PCbranchD,
                         hazardDetected,
                         PCSrcD,
                         equalD);
endmodule