module memory (           clk,
                          ALUOutM,
                          active,
                          address,
                          memWriteM,
                          );
    input clk,memWriteM;

    output reg active = 1'b1;
    reg [31:0] address_reg;

    output reg [31:0] address;
    input [31:0] ALUOutM;
    
    always @(posedge clk) begin
        
        case(memWriteM)
            1'b0: address <= ALUOutM;
            1'b1: address <= ALUOutM;
        endcase
        
    end
    
endmodule
