module Control(
    input wire hazard_detected,
    input wire [5:0] opcode,
    output reg [1:0] ALUOp,
    output reg ALUSrc, RegDst,                  
    output reg Branch, MemRead, MemWrite,
    output reg RegWrite, MemtoReg);
    
    always @* begin
      
      if(!hazard_detected) begin
      
      ALUSrc = 1'b0;
      RegDst = 1'b0;
      ALUOp = 2'b00;
      Branch = 1'b0;
      MemRead = 1'b0;
      MemWrite = 1'b0;
      RegWrite = 1'b0;
      MemtoReg = 1'b0;
      
      case(opcode)
        6'b100011: begin // LW instruction
            ALUSrc = 1'b1;
            MemRead = 1'b1;
            RegWrite = 1'b1;
            MemtoReg = 1'b1; 
          end
        6'b101011: begin // SW instrtuction       
            ALUSrc = 1'b1;
            MemWrite = 1'b1;
          end
        6'b001000: begin // Addi instruction      
            ALUSrc = 1'b1;
            ALUOp = 2'b10;
//            RegDst = 1'b1;
            RegWrite = 1'b1;
            MemtoReg = 1'b1;
        end
        6'b000100: begin // BEQ instruction      
            ALUOp = 1'b1;
            Branch = 1'b1;
        end
        6'b000000: begin // R-type instruction       
            ALUOp = 2'b10;
            RegDst = 1'b1;
            RegWrite = 1'b1;
            MemtoReg = 1'b1;
        end/*
        6'b000010: begin // jump instruction
            
        end*/
        default:;    
      endcase
    end
    
    else begin
      ALUSrc = 1'b0;
      RegDst = 1'b0;
      ALUOp = 2'b00;
      Branch = 1'b0;
      MemRead = 1'b0;
      MemWrite = 1'b0;
      RegWrite = 1'b0;
      MemtoReg = 1'b0;
    end
    end
endmodule
