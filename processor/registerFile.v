// 32 registers are implemented using array of 32 bits variable name will be reg[n]
// mux as ternary operators.
// flag involved in hazard for each register will be named as regFlag[n] and will be implemented as a single bit element array
// variables -> input-> clk, index(index of register), reset, val_to_write,


module registerFile (clk,
                     index1,
                     index2,
                     indexWB,
                     valueInput,
                     valueOutput1,
                     valueOutput2,
                     readEnable,
                     writeEnable,
                     regWriteW,
                     flagOutput1,
                     flagOutput2,
                     regWriteD,
                     regDstD,
                     RtD,
                     RdD);

    reg regFlags [31:0] ;             //We will initialise all of these elements as 1 in initial block of testbench
    reg [31:0] registers[31:0];
    input regWriteW;
    input regWriteD,regDstD;
    input [4:0] RtD,RdD;
    
    input[31:0]  valueInput;
    input[4:0] index1,index2,indexWB;
    input writeEnable,readEnable,clk;
    output reg [31:0] valueOutput1,valueOutput2;
    output reg flagOutput1,flagOutput2;
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            regFlags[i]  <= 1'b1;
            registers[i] <= 32'b0;
        end
    end

    always @(*) begin
        $display("%0d",registers[1]);
        $display("%0d",registers[2]);
        $display("%0d",registers[3]);
        $display("%0d",registers[4]);
        registers[0] <= 32'b0;

        valueOutput1 <= registers[index1];
        valueOutput2 <= registers[index2];
        
        if (regWriteW)
        begin
            registers[indexWB] <= valueInput;
            regFlags[indexWB]  <= 1;
        end
        flagOutput1 <= regFlags[index1];
        flagOutput2 <= regFlags[index2];

        if(regWriteD)begin
            case (regDstD)
                1'b0:regFlags[RtD] <= 0;
                1'b1:regFlags[RdD] <= 0; 
            endcase 
        end
        
    end
    
endmodule
