///////////////////////////////////////////////////////////////////////////////
// Module Name: Decoder_5to32
// Description: 5-to-32 bit decoder with Enable
//
// Ports: 
//    - Y: 32-bit one hot encoded output
//    - X: 5-bit input
//    - En: Enable input
///////////////////////////////////////////////////////////////////////////////

module Decoder_5to32(
    output [31:0] Y,
    input [4:0] X,
    input En
);
    wire [3:0] YtoEn;
    
    Decoder_2to4 U0 (.Y(YtoEn), .X(X[4:3]), .En(En));
    
    Decoder_3to8 U1 (.Y(Y[7:0]), .X(X[2:0]), .En(YtoEn[0]));
    Decoder_3to8 U2 (.Y(Y[15:8]), .X(X[2:0]), .En(YtoEn[1]));
    Decoder_3to8 U3 (.Y(Y[23:16]), .X(X[2:0]), .En(YtoEn[2]));
    Decoder_3to8 U4 (.Y(Y[31:24]), .X(X[2:0]), .En(YtoEn[3]));
    
endmodule
