module MEM_Stage(
    // system clock
    input wire clk,

    // datapath input
    input wire [31:0] EXtoMEM_ALUresult,
    input wire [31:0] EXtoMEM_ReadData2,
    input wire [4:0] EXtoMEM_RegDest,
    
    // control input
    input wire MemWrite,
    input wire MemRead,

    // datapath output
    output wire [31:0] MEM_ReadData,
    output wire [31:0] MEM_ALU_result,
    output wire [4:0] MEM_RegDest
);

    // Data Memory
    DataMemoryUnit Data_MEM (
        .clk(clk),
        .memWrite(MemWrite),
        .memRead(MemRead),
        .address(EXtoMEM_ALUresult),
        .writeData(EXtoMEM_ReadData2),
        .readData(MEM_ReadData)
    );

    // select signal of PC source
    assign MEM_RegDest = EXtoMEM_RegDest;
    assign MEM_ALU_result = EXtoMEM_ALUresult;

endmodule
