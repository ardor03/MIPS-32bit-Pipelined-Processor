module exeToMemReg(regWriteE,  //This is a buffer register.
                   memToRegE,
                   memWriteE,
                   ALUOut,
                   writeDataE,
                   writeRegE,
                   regWriteM,
                   memToRegM,
                   memWriteM,
                   ALUOutM,
                   writeDataM,
                   writeRegM,
                   clk);
    input regWriteE, memToRegE, memWriteE, clk;
    input [4:0] writeRegE;
    input [31:0] ALUOut, writeDataE;
    output reg regWriteM, memToRegM, memWriteM;
    output reg [4:0] writeRegM;
    output reg [31:0] ALUOutM, writeDataM;
    
    always@(negedge clk) begin
        
        regWriteM  <= regWriteE;
        memToRegM  <= memToRegE;
        memWriteM  <= memWriteE;
        writeRegM  <= writeRegE;
        ALUOutM    <= ALUOut;
        writeDataM <= writeDataE;
        
    end
endmodule
