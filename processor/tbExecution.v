`timescale 1ns/1ns

module testbenchexe ();
    reg clk;
    wire ALUSrcE,regDstE;
    wire regWriteE,memToRegE,memWriteE;
    wire [4:0] RsE,RtE,RdE;
    wire [3:0] ALUControlE;
    wire [4:0] writeRegE;
    
    wire [31:0] AluOutE;
    wire [1:0] ALUOpE;
    wire [31:0] value1,value2,signImmE;
    wire [31:0] writeDataE;
    
    initial begin
        $dumpfile("testbenchexe.vcd");
        $dumpvars(0,testbenchexe);
        clk                  = 1;
        repeat(5) #50 clk = ~clk ;
    end

    assign ALUSrcE=1'b0;
    assign ALUControlE= 4'b1111;
    assign regDstE = 1'b1;
    assign RsE = 5'b0;
    assign RtE = 5'd1;
    assign RdE = 5'd3;
    assign value1 = 32'd10;
    assign value2 = 32'd12;
    assign signImmE = 32'd100;
    assign ALUOpE = 2'd1;

    instructionExecution instructionExecution (clk,
                             regWriteE,
                             memToRegE,
                             memWriteE,
                             ALUControlE,
                             ALUOpE,
                             ALUSrcE,
                             regDstE,
                             signImmE,
                             RsE,
                             RtE,
                             RdE,
                             writeRegE,
                             AluOutE,
                             value1,
                             value2);

endmodule 
