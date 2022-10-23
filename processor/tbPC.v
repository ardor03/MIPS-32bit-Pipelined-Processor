`timescale 1ns/1ns

module testbench ();
    wire [31:0] inpPC,outPC;
    wire writeEnable;
    
    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0,testbench);
    end
    
    assign inpPC=32'b00000000000000100000000000000000;
    assign writeEnable = 1'b1;
    programCounter pc(inpPC,outPC,writeEnable);
endmodule
