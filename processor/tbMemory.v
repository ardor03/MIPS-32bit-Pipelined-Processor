`timescale 1ns/1ns

module testbench();
    reg clk;
    wire regWriteM, memToRegM, writeRegM;
    wire memWriteM;
    wire [31:0] writeDataM,readDataM;
    wire  active ;
    wire  [31:0] address_reg;
    wire[31:0] address,ALUOutM;
    
    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0,testbench);
        clk                  = 1;
        repeat(5000) #50 clk = ~clk;
    end
    assign regWriteM   = 1'b1;
    assign memToRegM   = 1'b1;
    assign writeRegM   = 1'b0;
    assign memWriteM   = 1'b0;
    assign writeDataM  = 32'b00000000000000000000000000000001;
    assign address_reg = 32'b0000000000000000000000000000000;
    assign ALUOutM     = 32'b00000000000000000000000000000001;
    
    memory  memory(clk,
    regWriteM,
    memToRegM,
    memWriteM,
    ALUOutM,
    writeDataM,
    writeRegM,
    active,
    readDataM);
    
endmodule
