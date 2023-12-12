module MIPS (
    input wire clk,
    input wire rst);


    //use IF_StageU0
    wire [31:0] pc_stage1;
    wire [31:0] inst_stage1;
    wire hazard_PCWrite;
    
    
    //use IFtoID_Register U1
    wire [31:0] pc_IFID;
    wire [31:0] inst_stage2;
    wire hazard_IF_ID_Write;
    
    
    //use ID_Stage U2
    wire [31:0] pc_stage2;
    wire [31:0] readData1_stage2;
    wire [31:0] readData2_stage2;
    wire [31:0] signExtended_stage2;
    wire [5:0] Op_stage2;
    wire [4:0] Rs_stage2, Rt_stage2, Rd_stage2;
    wire [5:0] funct_stage2;
    
    
    //use Control U3
    wire hazard_stall;
    wire [5:0] opcode;
    wire [1:0] Control_ALUOp;
    wire Control_ALUSrc, Control_RegDst, Control_Branch, Control_MemRead, Control_MemWrite, Control_RegWrite, Control_MemtoReg;


    //use IDtoEX_Register U4
    wire [31:0] pc_stage3;
    wire [31:0] readData1_stage3;
    wire [31:0] readData2_stage3;
    wire [31:0] signExtended_stage3;
    wire [4:0] Rs_stage3, Rt_stage3, Rd_stage3;
    wire [5:0] funct_stage3;
    
    wire [1:0] IDtoEX_ALUOp;
    wire IDtoEX_ALUSrc, IDtoEX_RegDst, IDtoEX_Branch, IDtoEX_MemRead, IDtoEX_MemWrite, IDtoEX_RegWrite, IDtoEX_MemtoReg;

    
    //use EX_Stage U6
    wire zero_stage3;
    wire [31:0] ALUresult_stage3;
    wire [4:0] EX_Rt_stage3;
    wire [31:0] Branch_Addr_stage3;
    wire [4:0] RegDest_stage3;
    
    wire [1:0] ForwardA_wire, ForwardB_wire;


    //use EXtoMEM_Register U7
    wire zero_stage4;
    wire [4:0] EXtoMEM_Rt_stage4;
    wire [31:0] ALUresult_stage4;
    wire [31:0] Branch_Addr_stage4;
    wire [4:0] RegDest_stage4;
    wire EXtoMEM_Branch, EXtoMEM_MemRead, EXtoMEM_MemWrite, EXtoMEM_RegWrite, EXtoMEM_MemtoReg;


    //use MEM_Stage U9
    wire [31:0] MEM_ReadData_stage4;
    wire [31:0] ALUresult_MEM;
    wire [4:0] RegDest_MEM;
    wire [31:0] MEM_PCSrc_Addr_stage4;
    wire PCSrc_stage4;


    // use MEMtoWB_Register U10
    wire [31:0] MEMtoWB_ReadData_stage5;
    wire [31:0] ALUresult_WB;
    wire [4:0] RegDest_WB;
    wire MEMtoWB_MemtoReg;
    wire MEMtoWB_RegWrite;
    
    
    
    // use WB_Stage U11
    wire [31:0] WriteData_stage5;

    IF_Stage U0 (
        .clk(clk),
        .rst(rst),
        .PCWrite(hazard_PCWrite),
        .PCSrc(PCSrc_stage4),
        .Branch(Branch_Addr_stage4),
        .IFtoID_PC(pc_stage1),
        .IFtoID_inst(inst_stage1)
    );



    IFtoID_Register U1 (
        .clk(clk),
        .rst(rst),
        .IF_PC(pc_stage1),
        .IF_inst(inst_stage1),
        .IF_ID_Write(hazard_IF_ID_Write),
        .ID_PC(pc_IFID),
        .ID_inst(inst_stage2)
    );



    ID_Stage U2 (
        .clk(clk),
        .rst(rst),
        .IFtoID_PC(pc_IFID),
        .IFtoID_inst(inst_stage2),
        .writeReg(RegDest_WB),
        .writeData(WriteData_stage5),
        .RegWrite(MEMtoWB_RegWrite),
        
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



    Control U3 (
        .hazard_detected(hazard_stall),
        .opcode(Op_stage2),
        .ALUOp(Control_ALUOp),
        .ALUSrc(Control_ALUSrc),
        .RegDst(Control_RegDst),
        .Branch(Control_Branch),
        .MemRead(Control_MemRead),
        .MemWrite(Control_MemWrite),
        .RegWrite(Control_RegWrite),
        .MemtoReg(Control_MemtoReg)
    );

    

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
    .MemRead(Control_MemRead), .MemWrite(Control_MemWrite), .RegWrite(Control_RegWrite), .MemtoReg(Control_MemtoReg),
 
 
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
    .IDtoEX_RegWrite(IDtoEX_RegWrite), .IDtoEX_MemtoReg(IDtoEX_MemtoReg)      // stage 5에서 사용
    
    );
    
    
    
    Hazard_Detection U5 (
        .ID_EX_MemRead(IDtoEX_MemRead),
        .ID_EX_Rt(Rt_stage3),
        .IF_ID_Rs(Rs_stage2),
        .IF_ID_Rt(Rt_stage2), 
        .PCWrite(hazard_PCWrite),
        .IF_ID_Write(hazard_IF_ID_Write),
        .Stall(hazard_stall)
    );
    
    
    
    EX_Stage U6 (
    // datapath input
    .IDtoEX_PCadd4(pc_stage3), // Program Counter
    .IDtoEX_ReadData1(readData1_stage3),.IDtoEX_ReadData2(readData2_stage3), // Read Data from Register File
    .IDtoEX_Imm(signExtended_stage3), // Sign extended immediate value
    .IDtoEX_Rt(Rt_stage3), .IDtoEX_Rd(Rd_stage3), // Destination Register
    
    // instruction input
    .funct(funct_stage3), // Function code
    
  // control inputs
    .ALUop(IDtoEX_ALUOp),
    .ALUSrc(IDtoEX_ALUSrc),
    .RegDst(IDtoEX_RegDst),
    
    // Forwarding inputs
    .EXtoMEM_ALUresult(ALUresult_stage4),
    .WB_ALUresult(/* WB에서 받을 것 */),
    
    // forwarding control
    .ForwardA(ForwardA_wire), .ForwardB(ForwardB_wire),
    
    // datapath output
    .zero(zero_stage3),
    .ALUresult(ALUresult_stage3),
    .EX_Rt(EX_Rt_stage3),
    .Branch_Addr(Branch_Addr_stage3), // computed branch address
//    output wire [31:0] Jump_address, // computed jump address
    .RegDest(RegDest_stage3) // Write data destination    
);


    
    EXtoMEM_Register U7 (
    .clk(clk), .rst(rst),
    
    // datapath input
    .EX_zero(zero_stage3),
    .EX_ALUresult(ALUresult_stage3),
    .EX_Rt(EX_Rt_stage3),
    .EX_Branch_Addr(Branch_Addr_stage3),
    .EX_RegDest(RegDest_stage3),
//    input wire [31:0] EX_Jump_address,

    // control input
    // MEM
    .EX_Branch(IDtoEX_Branch),
    .EX_MemRead(IDtoEX_MemRead),
    .EX_MemWrite(IDtoEX_MemWrite),
    // WB
    .EX_MemtoReg(IDtoEX_MemtoReg),
    .EX_RegWrite(IDtoEX_RegWrite),

    // datapath output
    .EXtoMEM_zero(zero_stage4),
    .EXtoMEM_ALUresult(ALUresult_stage4),
    .EXtoMEM_Rt(EXtoMEM_Rt_stage4),
    .EXtoMEM_Branch_Addr(Branch_Addr_stage4),
//    .EXtoMEM_Jump_address(),
    .EXtoMEM_RegDest(RegDest_stage4),
    
    // control output
    .MEM_Branch(EXtoMEM_Branch),
    .MEM_MemRead(EXtoMEM_MemRead),
    .MEM_MemWrite(EXtoMEM_MemWrite),
    // WB
    .MEM_MemtoReg(EXtoMEM_MemtoReg),
    .MEM_RegWrite(EXtoMEM_RegWrite)
);


    Forward_Unit U8 (
    .EX_MEM_Rd(RegDest_stage4), .MEM_WB_Rd(RegDest_WB),
    .ID_EX_Rs(Rs_stage3), .ID_EX_Rt(Rt_stage3),
    .MEM_WB_RegWrite(MEMtoWB_RegWrite), .EX_MEM_RegWrite(EXtoMEM_RegWrite),
    .ForwardA(ForwardA_wire), .ForwardB(ForwardB_wire)
    );



    MEM_Stage U9 (
    // system clock
    .clk(clk),

    // datapath input
    .EXtoMEM_zero(zero_stage4),
    .EXtoMEM_ALUresult(ALUresult_stage4),
    .EXtoMEM_Rt(EXtoMEM_Rt_stage4),
    .EXtoMEM_Branch_Addr(Branch_Addr_stage4),
//    .EXtoMEM_Jump_address(),
    .EXtoMEM_RegDest(RegDest_stage4),
    
    // control input
    .Branch(EXtoMEM_Branch),
    .MemWrite(EXtoMEM_MemWrite),
    .MemRead(IDtoEX_MemRead),
//    input wire Jump,

    // datapath output
    .MEM_ReadData(MEM_ReadData_stage4),
    .MEM_ALU_result(ALUresult_MEM),
    .MEM_RegDest(RegDest_MEM),
    .MEM_PCSrc_Addr(MEM_PCSrc_Addr_stage4),

    // control output
    .PCSrc(PCSrc_stage4)
    );
   

    
    MEMtoWB_Register U10 (
    .clk(clk), .rst(rst),

    // datapath input
    .MEM_ReadData(MEM_ReadData_stage4),
    .MEM_ALU_result(ALUresult_MEM),
    .MEM_RegDest(RegDest_MEM),

    // control input
    .MEM_MemtoReg(EXtoMEM_MemtoReg),
    .MEM_RegWrite(EXtoMEM_RegWrite),

    // datapath output
    .MEMtoWB_ReadData(MEMtoWB_ReadData_stage5),
    .MEMtoWB_ALU_result(ALUresult_WB),
    .MEMtoWB_RegDest(RegDest_WB),

    // control output
    .MEMtoWB_MemtoReg(MEMtoWB_MemtoReg),
    .MEMtoWB_RegWrite(MEMtoWB_RegWrite)
    );



    WB_Stage U11 (
    // datapath input
    .MEMtoWB_ReadData(MEMtoWB_ReadData_stage5),
    .MEMtoWB_ALU_result(ALUresult_WB),
    .MEMtoWB_RegDest(RegDest_WB),

    // control input
    .MemtoReg(MEMtoWB_MemtoReg),

    // datapath output
    .WB_WriteReg(WriteData_stage5),
    .WB_RegDest()
    );


endmodule
