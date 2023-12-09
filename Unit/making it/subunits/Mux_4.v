module Mux_4(
    input wire [31:0] X0, X1, X2, X3,
    input wire [1:0] sel,
    output reg [31:0] Y
    );
    
    always @*
      case(sel)
        0: Y = X0;
        1: Y = X1;
        2: Y = X2;
        default: Y = X3;
      endcase
endmodule
