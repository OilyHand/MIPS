module IFtoID_Register (input wire clk, rst,
  input wire [31:0] IF_PC, IF_inst,
  output reg [31:0] ID_PC, ID_inst);
 
 
 
  always @ (posedge clk) begin
    if (rst) begin
        ID_PC <= 0;
        ID_inst <= 0;
    end
    else begin
        ID_PC <= IF_PC;
        ID_inst <= IF_inst;
    end
  end
endmodule
