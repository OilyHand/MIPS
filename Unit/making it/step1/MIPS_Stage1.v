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
    output reg [31:0] pc,   // PC
    output reg [31:0] inst  // instruction
);
    reg  [31:0] pc_inner; // register를 바로 output에 연결 할 수 없기에 새로운 변수 생성

  
    ProgramCounter U0 (
        .clk(clk),
        
        .branchAddress(0),
        .branch(0),
        .jumpAddress(0),
        .jump(0),
        .PCWriteValue(0),
        .PCWrite(1),
        
        .pc(pc_inner)
    );

  
    InstructionMemory U1 (
        .clk(clk),
        .address(pc_inner),
        .instruction(inst)
    );


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // 리셋 신호가 활성화되면 초기값으로 리셋
            pc <= 32'h0;
        end else begin
            // 리셋이 아니면 PC 값을 업데이트
            pc <= U0.pc_inner;
            // 이제 wire pc에 값을 주고 output으로 갈 수 있게 함.
        end
    end

endmodule
