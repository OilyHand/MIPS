module MEM_Stage(
    // system clock
    input wire clk,

    // datapath input
    input wire EXtoMEM_zero,
    input wire [31:0] EXtoMEM_ALUresult,
    input wire [4:0] EXtoMEM_Rt,
    input wire [31:0] EXtoMEM_Branch_Addr,
//    input wire [31:0] EXtoMEM_Jump_address,
    input wire [4:0] EXtoMEM_RegDest,
    
    // control input
    input wire Branch,
    input wire MemWrite,
    input wire MemRead,
 //   input wire Jump,

    // datapath output
    output wire [31:0] MEM_ReadData,
    output wire [31:0] MEM_ALU_result,
    output wire [4:0] MEM_RegDest,
    output wire [31:0] MEM_PCSrc_Addr,

    // control output
    output wire PCSrc
    );

    // Data Memory
    DataMemoryUnit Data_MEM
    (
        .clk(clk),
        .memWrite(MemWrite),
        .memRead(MemRead),
        .address(EXtoMEM_ALUresult),
        .writeData(MEM_ALU_result),
        .readData(MEM_ReadData)
    );

    // select signal of PC source
    assign PCSrc = Branch & EXtoMEM_zero;
    assign MEM_PCSrc_Addr = EXtoMEM_Branch_Addr;
    // select next address
//    Mux_2 mux_PCSrc
//    (
//        .X0(EXtoMEM_Branch_Addr), .X1(EXtoMEM_Jump_address),
//        .sel(Jump),
//        .Y(MEM_PCSrc_Addr)
//    );

endmodule
