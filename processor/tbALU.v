`timescale 1ns/1ns

module testbench ();
    wire flag, branchD;
    wire [31:0] input1, input2, alu_out;
    wire [3:0] ex_cmd;
    wire [1:0] ALUOp;

    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0,testbench);
    end

    assign branchD = 1'b0;
    assign input1 = 32'd88;
    assign input2 = 32'd88;
    assign ex_cmd = 4'b1111;
    assign ALUOp = 2'd2;

    ALU ALU(input1, input2, flag, ex_cmd, alu_out, ALUOp, branchD);
    // always @(*) begin
    //     $display("%0d %0d",alu_out,flag);
    // end
endmodule
