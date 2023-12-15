module ID_Stage(
    input wire clk,
    input wire rst,
    input wire [31:0] IFtoID_PC,
    input wire [31:0] IFtoID_inst,
    
    input wire [4:0] writeReg,
    input wire [31:0] writeData,
    input wire RegWrite,
    
    output wire [31:0] IDtoEX_PC,
    output wire [31:0] IDtoEX_ReadData1, IDtoEX_ReadData2,
    output wire [31:0] IDtoEX_Imm,
    output wire [5:0] IFtoID_Op,    //31:26
    output wire [4:0] IFtoID_Rs,    //25:21
    output wire [4:0] IFtoID_Rt,    //20:16
    output wire [4:0] IFtoID_Rd,    //15:11
  //output wire [25:0] jump_instruction //25:0
    
    
    output wire [5:0] funct,
    
    output wire [31:0] output_t0, output_t1, output_t2, output_t3
);

    // Register File
    wire [31:0] RD1, RD2, t0, t1, t2, t3;
    wire [4:0] RR1, RR2, WR;
    wire [31:0] WD;
    wire WriteReg;
    
    wire [31:0] imm; // using sign extension
   
    // Instruction Decode
    assign RR1 = IFtoID_inst[25:21];
    assign RR2 = IFtoID_inst[20:16];   
    assign WR = writeReg;
    assign WD = writeData;
    assign WriteReg = RegWrite;
    
    
    RegisterFile u0 (
        .RD1(RD1),
        .RD2(RD2),
        .t0(t0),
        .t1(t1),
        .t2(t2),
        .t3(t3),
        .RR1(RR1),
        .RR2(RR2),
        .WR(WR),
        .WD(WD),
        .WriteReg(WriteReg),
        .clk(clk),
        .rst(rst)
    );


    SignExt u1 (
        .Y(imm),
        .X(IFtoID_inst[15:0])
    );


    // Output
 
    assign IDtoEX_PC = IFtoID_PC;
    assign IDtoEX_ReadData1 = RD1;
    assign IDtoEX_ReadData2 = RD2;
    assign IDtoEX_Imm = imm;
    
    assign IFtoID_Op = IFtoID_inst[31:26];   
    assign IFtoID_Rs = IFtoID_inst[25:21];
    assign IFtoID_Rt = IFtoID_inst[20:16];
    assign IFtoID_Rd = IFtoID_inst[15:11];
    assign funct = IFtoID_inst[5:0];
    
    assign output_t0 = t0;
    assign output_t1 = t1;   
    assign output_t2 = t2;
    assign output_t3 = t3;
    
endmodule
