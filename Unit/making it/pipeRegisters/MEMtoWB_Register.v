module MEMtoWB_Register (
    input clk, rst,

    // datapath input
    input wire [31:0] MEM_ReadData,
    input wire [31:0] MEM_ALU_result,
    input wire [4:0] MEM_RegDest,

    // control input
    input wire MEM_MemtoReg,
    input wire MEM_RegWrite,

    // datapath output
    output reg [31:0] MEMtoWB_ReadData,
    output reg [31:0] MEMtoWB_ALU_result,
    output reg [4:0] MEMtoWB_RegDest,

    // control output
    output reg MEMtoWB_MemtoReg,
    output reg MEMtoWB_RegWrite,

);

    always @(posedge clk) begin
        // datapath
        MEMtoWB_ReadData <= MEM_ReadData;
        MEMtoWB_ALU_result <= MEM_ALU_result;
        MEMtoWB_RegDest <= MEM_RegDest;

        // control
        MEMtoWB_MemtoReg <= MEM_MemtoReg;
        MEMtoWB_RegWrite <= MEM_RegWrite;
    end

endmodule