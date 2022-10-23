module memToWBReg(regWriteM,
                   memToRegM,
                   readDataM,
                   ALUOut,
                   writeRegM,
                   regWriteW,
                   memToRegW,
                   readDataW,
                   ALUOutW,
                   writeRegW,
                   clk);
    input clk, regWriteM, memToRegM;
    input [4:0] writeRegM;
    input [31:0] readDataM, ALUOut;
    output reg regWriteW, memToRegW;
    output reg [4:0] writeRegW;
    output reg [31:0] readDataW, ALUOutW;
    
    always@(negedge clk) begin
        
        regWriteW <= regWriteM;
        memToRegW <= memToRegM;
        writeRegW <= writeRegM;
        readDataW <= readDataM;
        ALUOutW   <= ALUOut;
    end
    
endmodule