module ID_Stage(
    input wire clk,
    input wire rst,
    input wire [31:0] IFtoID_PC,
    input wire [31:0] IFtoID_inst,
    
    output wire [31:0] IDtoEX_PC,
    output wire [31:0] IDtoEX_ReadData1, IDtoEX_ReadData2,
    output wire [31:0] IDtoEX_Imm,
    output wire [5:0] IFtoID_Rs,    //25:21
    output wire [5:0] IFtoID_Rt,    //20:16
    output wire [5:0] IFtoID_Rd     //15:11

/*    input wire [4:0] writeReg,
    input wire [31:0] writeData,
    input wire RegWrite */
);

    // Register File
    wire [31:0] RD1, RD2;
    wire [4:0] RR1, RR2, WR;
    wire [31:0] WD;
    wire WriteReg;
    wire [31:0] imm; // using sign extension
    wire ALUSrc, RegDst, Branch, MemRead, Memwrite, RegWrite, RegWrite, MemtoReg, PCSrc;
    wire [1:0] ALUOp;
    
    Control u0 (
        .hazard_detected(/*stall*/),
        .opcode(IFtoID_inst[31:26]),
        .ALUSrc(ALUSrc),
        .RegDst(RegDst),
        .ALUOp(ALUOp),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .RegWrite(RegWrite),
        .MemtoReg(MemtoReg),
        .PCSrc(PCSrc)
    );
    
    
    RegisterFile u1 (
        .RD1(RD1),
        .RD2(RD2),
        .RR1(RR1),
        .RR2(RR2),
        .WR(WR),
        .WD(WD),
        .WriteReg(WriteReg),
        .clk(clk)
    );


    SignExt u2 (
        .Y(imm),
        .X(IFtoID_inst[15:0])
    );


    // Instruction Decode
    assign RR1 = IFtoID_inst[25:21];
    assign RR2 = IFtoID_inst[20:16];
    assign WR = IFtoID_inst[15:11];
    assign WriteReg = (IFtoID_inst[31:26] == 6'b00000) ? 0 : 1; // R-type일 때 WriteReg 활성화


    // Mux for Write Data
    assign WD = (IFtoID_inst[31:26] == 6'b00000) ? IDtoEX_ReadData2 : imm;


    // Output
    assign IDtoEX_PC = IFtoID_PC;
    assign IDtoEX_ReadData1 = RD1;
    assign IDtoEX_ReadData2 = RD2;
    assign IDtoEX_imm = imm;
    assign IFtoID_Rs = IFtoID_inst[25:21];
    assign IFtoID_Rt = IFtoID_inst[20:16];
    assign IFtoID_Rd = IFtoID_inst[15:11];
/*    assign writeReg = WR;
    assign writeData = WD;
    assign RegWrite = WriteReg;
*/
endmodule
