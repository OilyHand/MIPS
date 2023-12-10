module Mux5_2(
    input wire [4:0] X0, X1,
    input wire sel,
    output reg [4:0] Y
    );
    
    always @*
      if (sel)
        Y = X1;
      else
        Y = X0;
    
endmodule
