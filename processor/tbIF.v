`timescale 1ns/1ns

module testbench ();
    reg clk;
    wire write,PCSrcD;
    wire [31:0] PC,PCbranchD;
    wire [31:0] instruction;
    
    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0,testbench);
        clk                  = 1;
        repeat(5) #50 clk = ~clk ;
    end

    // no hazard

    // assign PCbranchD=32'b0;
    // assign PCSrcD=1'b0;
    // assign write=1'b1;
    // assign hazardDetected=1'b0;

    // hazard

    assign PCbranchD=32'd8;
    assign PCSrcD=1'b1;
    assign write=1'b1;
    assign hazardDetected=1'b1;

    instructionFetch instructionFetch(clk,
                        PC,
                        instruction,
                        write,
                        PCbranchD,
                        PCSrcD,
                        hazardDetected);
endmodule 
