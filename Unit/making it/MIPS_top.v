module MIPS_top (
    input wire clk,
    input wire rst);

    wire [31:0] pc_stage1;
    wire [31:0] inst_stage1;

    IF_Stage U0 (
        .clk(clk),
        .rst(rst),
        .IFtoID_PC(pc_stage1),
        .IFtoID_inst(inst_stage1)
    );


    wire [31:0] pc_IFID;
    wire [31:0] inst_stage2;

    IFtoID_Register U1 (
        .clk(clk),
        .rst(rst),
        .IF_PC(pc_stage1),
        .IF_inst(inst_stage1),
        .ID_PC(pc_IFID),
        .ID_inst(inst_stage2)
    );

    wire [31:0] pc_stage2;
    wire [31:0] readData1_stage2;
    wire [31:0] readData2_stage2;
    wire [31:0] signExtended_stage2;
    wire [5:0] IFtoID_Op;
    wire [4:0] IFtoID_Rs, IFtoID_Rt, IFtoID_Rd;

    ID_Stage U2 (
        .clk(clk),
        .rst(rst),
        .IFtoID_PC(pc_IFID),
        .IFtoID_inst(inst_stage2),
        .writeReg(IFtoID_Rd),
        .writeData(IDtoEX_ReadData2),
        .RegWrite(U2_RegWrite),
        
        .IDtoEX_PC(pc_stage2),
        .IDtoEX_ReadData1(readData1_stage2),
        .IDtoEX_ReadData2(readData2_stage2),
        .IDtoEX_Imm(signExtended_stage2),
        .IFtoID_Op(IFtoID_Op),
        .IFtoID_Rs(IFtoID_Rs),
        .IFtoID_Rt(IFtoID_Rt),
        .IFtoID_Rd(IFtoID_Rd)
    );

    wire hazard_detected;
    wire [5:0] opcode;
    wire [1:0] Control_ALUOp;
    wire Control_ALUSrc, Control_RegDst, Control_Branch, Control_MemRead, Control_MemWrite, Control_RegWrite, Control_MemtoReg, Control_PCSrc;

    Control U3 (
        .hazard_detected(hazard_detected),
        .opcode(IFtoID_Op),
        .ALUOp(Control_ALUOp),
        .ALUSrc(Control_ALUSrc),
        .RegDst(Control_RegDst),
        .Branch(Control_Branch),
        .MemRead(Control_MemRead),
        .MemWrite(Control_MemWrite),
        .RegWrite(Control_RegWrite),
        .MemtoReg(Control_MemtoReg),
        .PCSrc(Control_PCSrc)
    );

endmodule
