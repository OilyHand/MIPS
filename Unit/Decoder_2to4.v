module Decoder_2to4(
    output reg [3:0] Y,
    input [1:0] X,
    input En
    );
    
    always @*
    if(En)
      case(X)
        0: Y = 2'b01;
        default: Y = 2'b10;
      endcase
    else
      Y = 0;
endmodule
