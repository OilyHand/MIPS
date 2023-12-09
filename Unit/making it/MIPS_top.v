module MIPS_top (
    input wire clk,
    input wire rst);

    wire [31:0] pc_stage1;
    wire [31:0] inst_stage1;

    IF_Stage U0 (
        .clk(clk),
        .rst(rst),
        .PCWrite(/*Hazard Detection unit으로 부터 받을 것*/),
        .PCSrc(/* MEM으로 부터 받을 것*/),
        .Branch(/* EX/MEM 으로 부터 받을 것*/),
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
    wire [5:0] Op_stage2;
    wire [4:0] Rs_stage2, Rt_stage2, Rd_stage2;
    wire [5:0] funct_stage2;

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
        .IFtoID_Op(Op_stage2),
        .IFtoID_Rs(Rs_stage2),
        .IFtoID_Rt(Rt_stage2),
        .IFtoID_Rd(Rd_stage2),
        .funct(funct_stage2)
    );


    wire hazard_detected;
    wire [5:0] opcode;
    wire [1:0] Control_ALUOp;
    wire Control_ALUSrc, Control_RegDst, Control_Branch, Control_MemRead, Control_MemWrite, Control_RegWrite, Control_MemtoReg, Control_PCSrc;

    Control U3 (
        .hazard_detected(hazard_detected),
        .opcode(Op_stage2),
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


    wire [31:0] pc_stage3;
    wire [31:0] readData1_stage3;
    wire [31:0] readData2_stage3;
    wire [31:0] signExtended_stage3;
    wire [4:0] Rs_stage3, Rt_stage3, Rd_stage3;
    wire [5:0] funct_stage3;
    
    wire [1:0] IDtoEX_ALUOp;
    wire IDtoEX_ALUSrc, IDtoEX_RegDst, IDtoEX_Branch, IDtoEX_MemRead, IDtoEX_MemWrite, IDtoEX_RegWrite, IDtoEX_MemtoReg, IDtoEX_PCSrc;
    

    IDtoEX_Register U4 (
    .clk(clk),
    .rst(rst),
    
    //input from ID_Stage
    .IFtoID_PC(pc_stage2),
    .IFtoID_ReadData1(readData1_stage2), .IFtoID_ReadData2(readData2_stage2),
    .IFtoID_Imm(signExtended_stage2),
    .IFtoID_Rs(Rs_stage2), .IFtoID_Rt(Rt_stage2), .IFtoID_Rd(Rd_stage2),
    .funct(funct_stage2),
 
 
    //input from Control
    .ALUOp(Control_ALUOp), .ALUSrc(Control_ALUSrc), .RegDst(Control_RegDst), .Branch(Control_Branch),
    .MemRead(Control_MemRead), .MemWrite(Control_MemWrite), .RegWrite(Control_RegWrite), .MemtoReg(Control_MemtoReg), .PCSrc(Control_PCSrc),
 
 
    // outputs to EX_Stage
    .IDtoEX_PC(pc_stage3), // Program Counter
    .IDtoEX_ReadData1(readData1_stage3),.IDtoEX_ReadData2(readData2_stage3), // Read Data from Register File
    .IDtoEX_Imm(signExtended_stage3), // Sign extended immediate value
    .IDtoEX_Rt(Rt_stage3), .IDtoEX_Rd(Rd_stage3), // Destination Register


    // Control unit to use in 3 stage
    .EX_ALUOp(IDtoEX_ALUOp),
    .EX_ALUSrc(IDtoEX_ALUSrc),
    .EX_RegDst(IDtoEX_RegDst),
    
    
    // outputs to Forwarding unit
    .Forwarding_Rs(Rs_stage3),
    
    
    // outputs to ALUcontrol
    .ALUcontrol_funct(funct_stage3), // Function code
    
    
    // outputs to next pipe
    .IDtoEX_Branch(IDtoEX_Branch), .IDtoEX_MemRead(IDtoEX_MemRead), .IDtoEX_MemWrite(IDtoEX_MemWrite),     // stage 4에서 사용
    .IDtoEX_RegWrite(IDtoEX_RegWrite), .IDtoEX_MemtoReg(IDtoEX_MemtoReg), .IDtoEX_PCSrc(IDtoEX_PCSrc)      // stage 5에서 사용
    
    );

endmodule
