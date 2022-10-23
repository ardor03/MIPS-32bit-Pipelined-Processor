`timescale 1ns/1ns

module testbench ();
    wire [31:0] PC;
    wire [31:0] instruction;
    
    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0,testbench);
    end
    
    assign PC=32'b00000000000000000000000000000001;

    instructionMem instructionMem(PC,instruction);
endmodule 
