`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/27 23:04:58
// Design Name: 
// Module Name: MIPS_Stage1
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


module MIPS_Stage1(
    input wire clk,
    input wire rst,
    output reg [31:0] pc,
    output wire [31:0] inst
);

    wire [31:0] pc_internal; // 중간 변수 추가

    ProgramCounter U0 (
        .clk(clk),
        .branchAddress(0),
        .branch(0),
        .jumpAddress(0),
        .jump(0),
        .PCWriteValue(0),
        .PCWrite(1),
        .pc(pc_internal) // 중간 변수에 연결
    );

    InstructionMemory U1 (
        .clk(clk),
        .address(pc_internal),
        .instruction(inst)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // 리셋 신호가 활성화되면 초기값으로 리셋
            pc <= 32'h0;
        end else begin
            // 리셋이 아니면 PC 값을 업데이트
            pc <= U0.pc;
        end
    end

endmodule
