// array of 512 elements each of 32 bit named memData[n]

module dataMemory(clk,
                  active,
                  rw,
                  indexData,
                  outputMem,
                  inputMem);
    input clk, rw, active;
    input [31:0] indexData, inputMem;
    output [31:0] outputMem;
    reg [31:0] outputMemReg;
    
    reg[31:0] memData[511:0];
    
    integer i;
    
    initial begin
        // Note that ++ operator does not exist in Verilog !
        for (i = 0; i < 512; i = i + 1) begin
            memData[i] <= 32'b0;
        end
    end
    
    always @(*) begin 
    //    $display("%0d",active);
        if (active)                          //decides if read write instruction is received
            case(rw)                         //decides read or write
                1'b1: begin
                    outputMemReg = memData[indexData];
                end
                1'b0: begin
                    memData[indexData] <= inputMem;
                    outputMemReg = 32'b0;
                end
                
            endcase
           
            end
        
        assign outputMem = outputMemReg;   
                //we will need a mux to decide if we don't want data to be returnrd in case of input
              always @(*) begin
                
                    //  $display("%0d",memData[indexData]);
                
              end
        
        endmodule