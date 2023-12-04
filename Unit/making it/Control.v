`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/04 12:01:48
// Design Name: 
// Module Name: Control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Control(
    input wire hazard_detected,
    input wire [5:0] opcode,
    output reg ALUSrc, RegDst,ALUOp1, ALUOp2, // stage 3에서 사용
    output reg Branch, MemRead, MemWrite,     // stage 4에서 사용
    output reg RegWrite, MemtoReg, PCSrc);    // stage 5 이후에서 사용


always @* begin
    if (hazard_detected == 0) begin
        {ALUSrc, RegDst, ALUOp1, ALUOp2, Branch, MemRead, MemWrite, RegWrite, MemtoReg, PCSrc} <= 0;
        if (opcode == 6'b100011) begin // LW instruction
            {ALUSrc, MemRead, RegWrite, MemtoReg} = 1; end
        else if (opcode == 6'b101011) begin // SW instrtuction
            {ALUSrc, MemWrite} = 1; end
        else if (opcode == 6'b000100) begin // BEQ instruction
            {ALUOp2, Branch} = 1; end
        else if (opcode == 6'b000000) begin // R-type instruction
            {RegDst, ALUOp1, RegWrite} = 1; end
    end
end
endmodule
