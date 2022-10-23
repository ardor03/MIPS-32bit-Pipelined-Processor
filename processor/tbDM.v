// `timescale 1ns/1ns

module testbench ();
    reg clk;
    wire active;
    reg rw;
    wire [31:0] index,inputMem,outputMem;
    
    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0,testbench);
        clk                  = 1;
        repeat(10) #50 clk = ~clk;
    end
    
    assign active    = 1'b1;
    assign index     = 32'b00000000000000000000000000000001;
    assign inputMem  = 32'b00000000000000000000000000000100;
    always @(*) begin
        case (active)
            1'b1:begin
                rw        = 1'b1;
                #50 rw = 1'b0;
                
            end 
             
        endcase
        
    end
    dataMemory dataMemory(clk, active, rw, index, outputMem, inputMem);
endmodule
