module SignExt(Y, X);
    output [31:0] Y;
    input [15:0] X;
    
    assign Y[15:0] = X;
    assign Y[31:16] = {16{X[15]}};
endmodule
