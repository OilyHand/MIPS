///////////////////////////////////////////////////////////////////////////////
// Module Name: Mux_32
// Description: 32-bit 32-to-1 Multiplexer
//
// Ports: 
//    - X0 ~ X31: 32-bit data input
//    - Y: 32-bit output
//    - Sel: 5-bit select input
///////////////////////////////////////////////////////////////////////////////

module Mux_32(
    output reg [31:0] Y,
    input [31:0] X0, X1, X2, X3, X4, X5, X6, X7, X8,
    input [31:0] X9, X10, X11, X12, X13, X14, X15, X16,
    input [31:0] X17, X18, X19, X20, X21, X22, X23, X24,
    input [31:0] X25, X26, X27, X28, X29, X30, X31,
    input [4:0] Sel
    );
    
    always @(Sel)
      case(Sel)
        0: Y = X0;
        1: Y = X1;
        2: Y = X2;
        3: Y = X3;
        4: Y = X4;
        5: Y = X5;
        6: Y = X6;
        7: Y = X7;
        8: Y = X8;
        9: Y = X9;
        10: Y = X10;
        11: Y = X11;
        12: Y = X12;
        13: Y = X13;
        14: Y = X14;
        15: Y = X15;
        16: Y = X16;
        17: Y = X17;
        18: Y = X18;
        19: Y = X19;
        20: Y = X20;
        21: Y = X21;
        22: Y = X22;
        23: Y = X23;
        24: Y = X24;
        25: Y = X25;
        26: Y = X26;
        27: Y = X27;
        28: Y = X28;
        29: Y = X29;
        30: Y = X30;
        default: Y = X31;
      endcase
endmodule
