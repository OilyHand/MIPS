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
  input wire [31:0] pcin, instin,
  output reg [31:0] pcout, instout);
 
 
 
  always @ (posedge clk) begin
    if (rst) begin
        pcout <= 0;
        instout <= 0;
    end
    else begin
        pcout <= pcin;
        instout <= instin;
    end
  end
endmodule
