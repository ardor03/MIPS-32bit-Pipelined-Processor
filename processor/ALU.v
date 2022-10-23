//variables-->input two wires.one directly from register file and other from a mux(deciding which to take from reg file and offset).
//input->wire from ALU control.
//output->1.a zero flag (for branching) 2.output of the arithmatic operation

module ALU (input1,
            input2,
            flag,
            ex_cmd,
            alu_out,
            ALUOp,
            branchD);
    input [31:0] input1, input2;
    input [3:0] ex_cmd;
    input [1:0] ALUOp;
    
    input branchD;
    output reg [31:0] alu_out;
    output reg flag,branchPresent;
    
    initial begin
        flag <= 32'd0;
    end
    
    always @(*) begin
        case (ALUOp)
            2'd2:  //arithmatic operations
            begin
                case(ex_cmd)
                    4'b0010: alu_out    <= input1 + input2;
                    4'b0110: alu_out    <= input1 - input2;
                    4'b0000: alu_out    <= input1 & input2;
                    4'b0001: alu_out    <= input1 | input2;
                    4'b1111: alu_out    <= input1 * input2;
                    default: alu_out    <= 0;
                endcase
            end
            2'd0: alu_out <= input1 + input2;  //load store
            2'd1:  //branch
            begin
                alu_out <= input1 - input2;
                case(alu_out)
                    32'd0:flag <= 32'd1;
                    default:flag <= 32'd0;
                endcase
            end
        endcase 
    end
endmodule
