`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/27 23:28:40
// Design Name: 
// Module Name: MIPS_Stage2
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


module MIPS_Stage2(
    input wire clk,
    input wire rst,
    input wire [31:0] pc,
    input wire [31:0] inst,
    output wire [31:0] readData1,
    output wire [31:0] readData2,
    output wire [31:0] signExtended,
    output wire [4:0] writeReg,
    output wire [31:0] writeData,
    output wire RegWrite
);

    // Register File
    wire [31:0] RD1, RD2;
    wire [4:0] RR1, RR2, WR;
    wire [31:0] WD;
    wire WriteReg;
    
    RegisterFile U0 (
        .RD1(RD1),
        .RD2(RD2),
        .RR1(RR1),
        .RR2(RR2),
        .WR(WR),
        .WD(WD),
        .WriteReg(WriteReg),
        .clk(clk)
    );


    // Sign Extension
    wire [31:0] imm;
    SignExt U1 (
        .Y(imm),
        .X(inst[15:0])
    );


    // Instruction Decode
    assign RR1 = inst[25:21];
    assign RR2 = inst[20:16];
    assign WR = inst[15:11];
    assign WriteReg = (inst[31:26] == 6'b00000) ? 0 : 1; // R-type일 때 WriteReg 활성화

    // Mux for Write Data
    assign WD = (inst[31:26] == 6'b00000) ? readData2 : imm;

    // Output
    assign readData1 = RD1;
    assign readData2 = RD2;
    assign signExtended = imm;
    assign writeReg = WR;
    assign writeData = WD;
    assign RegWrite = WriteReg;

endmodule
