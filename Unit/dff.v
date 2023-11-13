///////////////////////////////////////////////////////////////////////////////
// Module Name: dff
// Description: 32-bit D flip-flop with active rising edge clock and Enable
//
// Ports: 
//    - Q: 32-bit output
//    - D: 32-bit input
//    - clk: system clock
//    - En: Synchronous Enable
///////////////////////////////////////////////////////////////////////////////

module dff(
    output reg [31:0] Q,
    input [31:0] D,
    input clk, En
);
    always @(posedge clk)
      if(En) Q <= D;
endmodule
