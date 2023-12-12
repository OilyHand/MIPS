module IFtoID_Register (
    input wire clk, rst,
    input wire [31:0] IF_PC, IF_inst,
    input wire IF_ID_Write,
    
    output reg [31:0] ID_PC, ID_inst);
 
 
    reg [31:0] prev_IF_PC;      //이전 값 저장
    reg [31:0] prev_IF_inst;    //이전 값 저장
 
 
  always @ (posedge clk or posedge rst) begin
    if (rst) begin
        ID_PC <= 0;
        ID_inst <= 0;
        prev_IF_PC <= 0;      //이전 값 저장
        prev_IF_inst <= 0;
    end
    
    else begin
        if(IF_ID_Write) begin
            ID_PC <= IF_PC;
            ID_inst <= IF_inst;
        end
        else begin
            ID_PC <= prev_IF_PC;
            ID_inst <= prev_IF_inst;
        end
      prev_IF_PC <= IF_PC;
      prev_IF_inst <= IF_inst;
    end
  end
endmodule
