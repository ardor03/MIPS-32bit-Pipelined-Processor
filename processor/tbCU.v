`timescale 1ns/1ns

module testbench ();
    reg clk;
    wire regWriteD,memToRegD,memWriteD,ALUSrcD,regDstD,branchD;
    wire [1:0] ALUOp;
    wire [3:0] ALUControlD;
    wire [31:0] instruction;
    initial begin
        $dumpfile("testbenchcu.vcd");
        $dumpvars(0,testbench);
        clk                  = 1;
        repeat(5) #50 clk = ~clk;
    end
    
    assign instruction = 32'b00000000010000110000100000100000;
    // always@(*)begin
    //     $display("%0d",ALUOp);
    //     $display("%0d",instruction[31:26]);
    // end

    controlUnit controlUnit(clk, instruction, regWriteD, memToRegD, memWriteD, ALUControlD, ALUSrcD, regDstD, branchD, ALUOp);
    
endmodule
