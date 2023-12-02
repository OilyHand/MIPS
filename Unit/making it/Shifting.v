module Shifting(
    input [31:0] Din,
    input [4:0] shamt,
    input left,
    output reg [31:0] Dout
    );
    
    always @*
      if(left)
        Dout = Din << shamt;
      else
        Dout = Din >> shamt;
endmodule
