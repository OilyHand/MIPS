`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/01 02:09:26
// Design Name: 
// Module Name: IFID
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

module IFtoID_Register (input wire clk, rst,
  input wire [31:0] IF_PC, IF_inst,
  output reg [31:0] ID_PC, ID_inst);
 
 
 
  always @ (posedge clk) begin
    if (rst) begin
        ID_PC <= 0;
        ID_inst <= 0;
    end
    else begin
        ID_PC <= IF_PC;
        ID_inst <= IF_inst;
    end
  end
endmodule
