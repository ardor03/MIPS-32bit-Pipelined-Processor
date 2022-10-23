`timescale 1ns/1ns

module testbench();
    reg clk;
    wire  memToRegW,regWriteW;
    wire [31:0] ALUOutW,readDataW;
    wire [4:0] writeRegW;
    wire [31:0] resultW;
    // wire  [31:0] resultW_reg;
    
    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0,testbench);
        clk                  = 1;
        repeat(5000) #50 clk = ~clk;
    end
    assign memToRegW = 1'b0;
    assign regWriteW = 1'b1;
    assign ALUOutW   = 32'b00000000000000000000000000000011;
    assign readDataW = 32'b00000000000000000000000000000001;
    assign writeRegW = 5'b00101;
    writeBack writeBack(memToRegW,regWriteW, readDataW, ALUOutW,resultW,clk);
    // always @(*) begin
    //     $display("%0d",writeRegW);
    // end
    
endmodule
//test passed