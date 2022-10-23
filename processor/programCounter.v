module programCounter(inpPC,
                      outPC,
                      writeEnable);
    input writeEnable;
    input [31:0] inpPC;
    output wire [31:0] outPC;
    reg[31:0] outPCReg;

    always @(*) begin
        case(writeEnable)
            1'b1: outPCReg <= inpPC;
        endcase
    end
    assign outPC = outPCReg;
    
endmodule
