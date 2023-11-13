///////////////////////////////////////////////////////////////////////////////
// Module Name: SignExt
// Description: 16-to-32 bit sign extention module
//
// Ports: 
//    - X: 16-bit input
//    - Y: 32-bit output
///////////////////////////////////////////////////////////////////////////////

module SignExt(Y, X);
    output [31:0] Y;
    input [15:0] X;
    
    assign Y[15:0] = X;
    assign Y[31:16] = {16{X[15]}};
endmodule
