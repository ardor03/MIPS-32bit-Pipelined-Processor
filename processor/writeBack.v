module writeBack(memToRegW,
                 regWriteW,
                 readDataW,
                 ALUOutW,
                 resultW,
                 clk);
    input memToRegW,clk,regWriteW;
    input [31:0] ALUOutW,readDataW;
    input [4:0] writeRegW;
    output reg [31:0] resultW;
    reg  [31:0] resultW_reg;
    
    always@(posedge clk) begin
        
        if (memToRegW)begin
            #0.01 resultW <= readDataW;
        end
        else begin
            #0.01 resultW <= ALUOutW;
        end

    end
    
endmodule
