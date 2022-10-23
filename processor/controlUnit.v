module controlUnit(clk,
                   instruction,
                   regWriteD,
                   memToRegD,
                   memWriteD,
                   ALUControlD,
                   ALUSrcD,
                   regDstD,
                   branchD,
                   BNEType,     //IT IS ONE WHEN INSTRUCTION IS BNE
                   ALUOp);
    input clk;
    input [31:0] instruction;
    output  reg regWriteD,memToRegD,memWriteD,ALUSrcD,regDstD,branchD,BNEType;
    output reg[3:0]ALUControlD;
    output reg[1:0] ALUOp;
    
    
    always @(*) begin
        
        case(instruction[31:26])
            6'b000000:// THIS IMPLIES IT IS R TYPE
            begin
                ALUOp     <= 2'd2;
                regDstD   <= 1;
                regWriteD <= 1;// tells about write back
                memToRegD <= 0;// write back from  ALU or data mem
                memWriteD <= 0;// memory write
                ALUSrcD   <= 0;// r branch o
                branchD   <= 0;//all except branch type
                BNEType   <= 0;//indicates it is not a bne if 0
                
                
            end
            6'b000100://BRANCH
            begin
                ALUOp     <= 2'd1;
                regWriteD <= 0;
                branchD   <= 1;
                memToRegD <= 0;// write back from  ALU or data mem
                memWriteD <= 0;// memory write
                ALUSrcD   <= 0;// r branch o
                regDstD   <= 0;// all except r type
                BNEType   <= 0;
                
            end
            6'b001000: //BNE
            begin
                ALUOp       <= 2'd2;
                BNEType     <= 1;
                regWriteD   <= 0 ;
                memToRegD   <= 0;// write back from  ALU or data mem
                memWriteD   <= 0;// memory write
                ALUSrcD     <= 0;// r branch o
                regDstD     <= 0;// all except r type
                branchD     <= 1;//all except branch type
                ALUControlD <= 4'b0110;
                
                
            end
            6'b001001: //ADDI
            begin              

                ALUOp       <= 2'd2;
                BNEType     <= 0;
                regWriteD   <= 1 ;
                ALUControlD <= 4'b0010;
                memToRegD   <= 0;// write back from  ALU or data mem
                memWriteD   <= 0;// memory write
                ALUSrcD     <= 1;// r branch o
                regDstD     <= 0;// all except r type
                branchD     <= 0;//all except branch type
                // $display("hii %0d",branchD);

            end
            6'b100011:
            begin
                ALUOp     <= 2'b0;// LOAD-store
                memToRegD <= 1;//load
                regWriteD <= 1;// tells about write back
                ALUSrcD   <= 1;
                memWriteD <= 0;// memory write
                regDstD   <= 0;// all except r type
                branchD   <= 0;//all except branch type
                BNEType   <= 0;
                
            end
            6'b101011:begin //store
                ALUOp     <= 2'b0;// LOAD-store
                regWriteD <= 0 ;
                memWriteD <= 1;
                memToRegD <= 0;// write back from  ALU or data mem
                regDstD   <= 0;// all except r type
                ALUSrcD   <= 1;
                branchD   <= 0;//all except branch type
                BNEType   <= 0;
                
                
            end
            
        endcase
        case(ALUOp[1:0])
            2'd2:begin
                case(instruction[5:0])
                    6'b100000:ALUControlD     <= 4'b0010;  //ADD R TYPE
                    6'b100010:ALUControlD     <= 4'b0110;  //SUB R TYPE
                    6'b100100:ALUControlD     <= 4'b0000;  //and r type
                    6'b100101:ALUControlD     <= 4'b0001;  //or r type
                    6'b011000:ALUControlD     <= 4'b1111;  //multipication r type
                    
                endcase
            end
            2'd0:ALUControlD    <= 4'b0010;  //load-store
            
        endcase
    end
endmodule
    
    
