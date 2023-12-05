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
    wire [4:0] writeReg_stage2;
    wire [31:0] writeData_stage2;
    
    wire ALUSrc_stage2;
    wire [1:0] ALUOp_stage2;
    wire RegDst_stage2;
    wire Branch_stage2;
    wire MemRead_stage2;
    wire MemWrite_stage2;
    wire RegWrite_stage2;
    wire MemtoReg_stage2;
    wire PCSrc_stage2;

    ID_Stage U2 (
        .clk(clk),
        .rst(rst),
        .IFtoID_PC(pc_IFID),
        .IFtoID_inst(inst_stage2),
        
        .IDtoEX_PC(pc_stage2),
        .IDtoEX_ReadData1(readData1_stage2),
        .IDtoEX_ReadData2(readData2_stage2),
        .IDtoEX_Imm(signExtended_stage2),
        .IFtoID_Rs(inst_stage2 [25:21]),    //25:21
        .IFtoID_Rt(inst_stage2 [20:16]),    //20:16
        .IFtoID_Rd(inst_stage2 [15:11]),    //15:11
        
        .IDtoEX_ALUSrc(ALUSrc_stage2),
        .IDtoEX_ALUOp(ALUOp_stage2),
        .IDtoEX_RegDst(RegDst_stage2),
        
        .IDtoEX_Branch(Branch_stage2),
        .IDtoEX_MemRead(MemRead_stage2),
        .IDtoEX_MemWrite(MemWrite_stage2),
        
        .IDtoEX_RegWrite(RegWrite_stage2),
        .IDtoEX_MemtoReg(MemtoReg_stage2),
        .IDtoEX_PCSrc(PCSrc_stage2)
        
/*        .writeReg(writeReg_stage2),
        .writeData(writeData_stage2),
        .RegWrite(RegWrite_stage2)
 */   );
 
 
 
    wire [31:0] pc_IDEX;
    wire [31:0] inst_stage3;
    wire [31:0] readData1_stage3;
    wire [31:0] readData2_stage3;
    wire [31:0] signExtended_stage3;
    wire [4:0] writeReg_stage3;
    wire [31:0] writeData_stage3;
    
    wire ALUSrc_stage3;
    wire [1:0] ALUOp_stage3;
    wire RegDst_stage3;
    wire Branch_stage3;
    wire MemRead_stage3;
    wire MemWrite_stage3;
    wire RegWrite_stage3;
    wire MemtoReg_stage3;
    wire PCSrc_stage3; 
 
    IDtoEX_Register U3 (
        .clk(clk),
        .rst(rst),
        .readData1(readData1_stage2),
        .readData2(readData1_stage2),
        .signExtended(signExtended_stage2),
        .IFtoID_Rs(inst_stage2 [25:21]),    //25:21
        .IFtoID_Rt(inst_stage2 [20:16]),    //20:16
        .IFtoID_Rd(inst_stage2 [15:11]),    //15:11
 
    // outputs from ID/EX pipeline register
    .IDtoEX_PC(pc_IDEX), // Program Counter
    .IDtoEX_ReadData1(readData1_stage3),
    .IDtoEX_ReadData2(readData2_stage3), // Read Data from Register File
    .IDtoEX_Imm(signExtended_stage3), // Sign extended immediate value
    .IDtoEX_Rt(inst_stage3 [20:16]), 
    .IDtoEX_Rd(inst_stage3 [15:11]), // Destination Register
    .funct(), // Function code
    // Control inputs
    .ALUop(ALUOp_stage3),
    .ALUSrc(ALUSrc_stage3),
    .RegDst(RegDst_stage3),
    // Forwarding inputs
    .EXtoMEM_ALUresult(),
    .WB_ALUresult(),
    // forwarding control
    .ForwardA(), .ForwardB()
    );
endmodule
