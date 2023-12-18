module IFtoID_Register (
    input wire clk, rst,
    input wire [31:0] IF_PC, IF_inst,
    input wire IF_ID_Write, IF_Flush,
    output reg [31:0] ID_PC, ID_inst
);
  wire [31:0] next_inst, next_PC;
  
  
  always @ (posedge clk or posedge rst) begin
    if (rst) begin
        ID_PC <= 0;
        ID_inst <= 0;
    end    
    else begin
        if(IF_ID_Write) begin
            ID_PC <= next_PC;
            ID_inst <= next_inst;
        end
        else begin
            ID_PC <= ID_PC;
            ID_inst <= ID_inst;
        end
    end
  end

  assign next_PC = (IF_Flush == 1) ? 32'd0 : IF_PC;
  assign next_inst = (IF_Flush == 1) ? 32'd0 : IF_inst;
endmodule
