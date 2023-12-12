module EXtoMEM_Register(
    input wire clk, rst,
    
    // datapath input
    input wire EX_zero,
    input wire [31:0] EX_ALUresult,
    input wire [4:0] EX_Rt,
    input wire [31:0] EX_Branch_Addr,
    input wire [4:0] EX_RegDest,
 //   input wire [31:0] EX_Jump_address,

    // control input
    // MEM
    input wire EX_Branch,
    input wire EX_MemRead,
    input wire EX_MemWrite,
    // WB
    input wire EX_MemtoReg,
    input wire EX_RegWrite,

    // datapath output
    output reg EXtoMEM_zero,
    output reg [31:0] EXtoMEM_ALUresult,
    output reg [4:0] EXtoMEM_Rt,
    output reg [31:0] EXtoMEM_Branch_Addr,
//    output reg [31:0] EXtoMEM_Jump_address,
    output reg [4:0] EXtoMEM_RegDest,
    
    // control output
    output reg MEM_Branch,
    output reg MEM_MemRead,
    output reg MEM_MemWrite,
    // WB
    output reg MEM_MemtoReg,
    output reg MEM_RegWrite
);

    always @(posedge clk) begin
        // datapath
        EXtoMEM_zero <= EX_zero;
        EXtoMEM_ALUresult <= EX_ALUresult;
        EXtoMEM_Rt <= EX_Rt;
        EXtoMEM_Branch_Addr <= EX_Branch_Addr;
        EXtoMEM_RegDest <= EX_RegDest;
//        EXtoMEM_Jump_address <= EX_Jump_address;

        // control
        MEM_Branch <= EX_Branch;
        MEM_MemRead <= EX_MemRead;
        MEM_MemWrite <= EX_MemWrite;
        MEM_MemtoReg <= EX_MemtoReg;
        MEM_RegWrite <= EX_RegWrite;
    end

endmodule
