module Control(
    input wire hazard_detected,
    input wire [5:0] opcode,
    output reg [1:0] ALUOp,                   // stage 3에서 사용
    output reg ALUSrc, RegDst,                  
    output reg Branch, MemRead, MemWrite,     // stage 4에서 사용
    output reg RegWrite, MemtoReg, PCSrc);    // stage 5 이후에서 사용

    
always @* begin
    if (hazard_detected == 0) begin   
        ALUSrc <= 1'b0;
        RegDst <= 1'b0;
        ALUOp <= 1'b0;
        Branch <= 1'b0;
        MemRead <= 1'b0;
        MemWrite <= 1'b0;
        RegWrite <= 1'b0;
        MemtoReg <= 1'b0;
        PCSrc <= 1'b0;
        
        if (opcode == 6'b100011) begin // LW instruction
            ALUSrc <= 1'b1;
            MemRead <= 1'b1;
            RegWrite <= 1'b1;
            MemtoReg <= 1'b1; end 
            
        else if (opcode == 6'b101011) begin // SW instrtuction       
            ALUSrc <= 1'b1;
            MemWrite <= 1; end
            
        else if (opcode == 6'b000100) begin // BEQ instruction      
            ALUOp <= 1'b1;
            Branch <= 1'b1; end
            
        else if (opcode == 6'b000000) begin // R-type instruction       
            ALUOp <= 2'b10;
            RegDst <= 1'b1;
            RegWrite <= 1'b1; end
            
    end
    else begin
    end
    
end
endmodule
