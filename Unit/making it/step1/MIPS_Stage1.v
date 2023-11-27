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

// synthesis, Implementation 통과

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

// synthesis, Implementation 통과

module MIPS_Stage1(
    input wire clk,
    input wire rst,
    output wire [31:0] pc,
    output wire [31:0] inst
);
    reg [31:0] pc_reg; // 중간 변수 추가
    wire [31:0] add_result;

    ProgramCounter U0 (
        .clk(clk),
        .branchAddress(0),
        .branch(0),
        .jumpAddress(0),
        .jump(0),
        .PCWriteValue(0), // pc를 control과 연결하지 않을 경우 빼기
        .PCWrite(1),
        .pc(pc) // 중간 변수에 연결
    );

    Adder U2 (
        .operandA(pc),
        .operandB(4),
        .sum(add_result)
    );

    InstructionMemory U1 (
        .clk(clk),
        .address(pc),
        .instruction(inst)
    );
    

    always @(posedge clk or posedge rst) begin // negedge rst 사용하는 것도 고려해보기
        if (rst) begin
            // 리셋 신호가 활성화되면 초기값으로 리셋
            pc_reg <= 32'h0;
        end else begin
            // 리셋이 아니면 PC 값을 업데이트
            pc_reg <= U2.sum;
        end
    end
    
    assign pc = pc_reg;


endmodule
