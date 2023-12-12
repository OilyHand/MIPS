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

module IF_Stage(
        input wire clk,
        input wire rst,
        
        input wire PCWrite,
        input wire PCSrc,
        input wire [31:0] Branch,
        
        output wire [31:0] IFtoID_PC,
        output wire [31:0] IFtoID_inst
    );
        wire [31:0] add_result;
        wire [31:0] Branch_value;
        
        wire ID_PCWrite;
        wire ID_PCSrc;
        
        wire [31:0] MuxtoPC;
        wire [31:0] PCtoInst;
        
        assign Branch_value = Branch;
        assign ID_PCSrc = PCSrc;
  
        Mux_2 u0 (
            .X0(add_result),
            .X1(Branch_value),
            .sel(ID_PCSrc),
            .Y(MuxtoPC)
        );
    
    
        ProgramCounter u1 (
            .clk(clk),
            .PCWriteValue(MuxtoPC),
            .PCWrite(ID_PCWrite),
            .pc(PCtoInst) // 중간 변수에 연결
        );
    
    
        Adder u2 (
            .operandA(PCtoInst),
            .operandB(4),
            .sum(add_result)
        );
    
    
        InstructionMemory u3 (
            .clk(clk),
            .address(PCtoInst),
            .instruction(IFtoID_inst)
        );
        
        assign IFtoID_PC = add_result;
    
    endmodule
