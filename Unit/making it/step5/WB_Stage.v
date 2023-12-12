module WB_Stage(
    // datapath input
    input wire [31:0] MEMtoWB_ReadData,
    input wire [31:0] MEMtoWB_ALU_result,
    input wire [4:0] MEMtoWB_RegDest,

    // control input
    input wire MemtoReg,

    // datapath output
    output wire [31:0] WB_WriteReg,
    output wire WB_RegDest
    );
    
    Mux_2 mux_WB
    (
        .X0(MEMtoWB_ReadData), .X1(MEMtoWB_ALU_result),
        .sel(MemtoReg),
        .Y(WB_WriteReg)
    );

    assign WB_RegDest = MEMtoWB_RegDest;
    
endmodule
