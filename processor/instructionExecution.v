module instructionExecution (clk,
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
                             value2,
                             SrcAE,
                             SrcBE,
                             writeDataE);

    input clk,ALUSrcE,regDstE;
    input [4:0] RsE,RtE,RdE;
    input [1:0] ALUOpE;
    input [3:0] ALUControlE;                                                                                        
    output reg [4:0] writeRegE;
    output reg [31:0] SrcAE,SrcBE;
    output [31:0] AluOutE;
    input [31:0] value1,value2,signImmE;
    output reg [31:0] writeDataE;
    
    always @(posedge clk) begin
        SrcAE      <= value1;
        writeDataE <= value2;
        case (ALUSrcE)
            1'b0: SrcBE <= value2;
            1'b1: SrcBE <= signImmE;
        endcase
        
        case (regDstE)
            1'b0: writeRegE <= RtE;
            1'b1: writeRegE <= RdE;
        endcase
        
    end
endmodule
