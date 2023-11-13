module Decoder_3to8(
    output reg [7:0] Y,
    input [2:0] X,
    input En
    );
    always @*
    if(En)
      case(X)
        0: Y = 8'b00000001;
        1: Y = 8'b00000010;
        2: Y = 8'b00000100;
        3: Y = 8'b00001000;
        4: Y = 8'b00010000;
        5: Y = 8'b00100000;
        6: Y = 8'b01000000;
        default: Y = 8'b10000000;
      endcase
    else
      Y = 0;
endmodule
