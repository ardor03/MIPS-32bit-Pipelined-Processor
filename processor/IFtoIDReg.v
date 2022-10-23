module IFtoIDReg(instruction,
                 instructionD,
                 clk,
                 reset,
                 PCReg,
                 outPC);
    input [31:0] instruction;
    input [31:0] outPC;
    input clk;
    input reset;
    
    output reg [31:0] instructionD;
    output reg [31:0] PCReg;
    
    
    always @(negedge clk) begin
        
        #0.01 instructionD <= instruction;
        PCReg        <= outPC+32'd4;  //leads to the next instruction

    end
    
endmodule
