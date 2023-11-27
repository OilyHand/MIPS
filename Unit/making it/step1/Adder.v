`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/28 00:47:03
// Design Name: 
// Module Name: Adder
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


module Adder(
    input wire [31:0] operandA, // 피연산자 A
    input wire [31:0] operandB, // 피연산자 B
    output wire [31:0] sum       // 덧셈 결과
);

    assign sum = operandA + operandB;

endmodule
