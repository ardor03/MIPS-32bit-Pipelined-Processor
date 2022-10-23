module IDtoExe(clk,
               regWriteD,
               memToRegD,
               memWriteD,
               ALUControlD,
               ALUSrcD,
               regDstD,
               data1,
               data2,
               data11,
               data22,
               regWriteE,
               memToRegE,
               memWriteE,
               ALUControlE,
               ALUSrcE,
               regDstE,
               RsD,
               RtD,
               RdD,
               signImmD,
               RsE,
               RtE,
               RdE,
               signImmE,
               ALUOp,
               ALUOpE,
               hazardDetected);
    input  regWriteD,memToRegD,memWriteD,ALUSrcD,regDstD,clk,hazardDetected;
    input [3:0] ALUControlD;
    input [1:0] ALUOp;
    input [4:0] RsD,RtD,RdD;
    input [31:0]signImmD,data1,data2;
    output reg regWriteE,memToRegE,memWriteE,ALUSrcE,regDstE;
    output reg [1:0] ALUOpE;
    output reg[3:0] ALUControlE;
    output reg [4:0] RsE,RtE,RdE;
    output reg [31:0]signImmE,data11,data22;
   
    always@(negedge clk) begin
        if(hazardDetected)begin
            regWriteE   <= 1'b0;
        memToRegE   <= 1'b0;
        memWriteE   <= 1'b0;
        ALUControlE <= 4'b0000;
        ALUSrcE     <= 1'b0;
        regDstE     <= 1'b0;
        RsE         <= 5'b00000;
        RtE         <= 5'b00000;
        RdE         <= 5'b00000;
        data11      <= 32'b0000000000000000000000000000000;
        data22      <= 32'b0000000000000000000000000000000;
        signImmE <= 32'b0000000000000000000000000000000;
        ALUOpE   <= 2'b00;
        end
        else begin
        regWriteE   <= regWriteD;
        memToRegE   <= memToRegD;
        memWriteE   <= memWriteD;
        ALUControlE <= ALUControlD;
        ALUSrcE     <= ALUSrcD;
        regDstE     <= regDstD;
        RsE         <= RsD;
        RtE         <= RtD;
        RdE         <= RdD;
        data11      <= data1;
        data22      <= data2;
        signImmE <= signImmD;
        ALUOpE   <= ALUOp;
    end
    end
    
endmodule
