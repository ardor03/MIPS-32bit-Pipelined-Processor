module finalTestBench();  //This is the final testbench for the processor
    reg clk;
    wire rst;
    
    
    initial begin
        
        $dumpfile("testbenchfinal.vcd");  //This helps in dumping the resultant as a waveform 
        $dumpvars(0,finalTestBench);
        clk               = 1;
        repeat(5000) #50 clk = ~clk;

    end
    assign rst = 1'b0;

    topLevel topLevel(
    .clk(clk),
    .rst(rst)
    );
endmodule
