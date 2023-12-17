module MIPS (
    input wire clk,
    input wire rst,
    
    output wire [31:0] ProgramCounter_Output,
    output wire [31:0] Register_0, Register_1, Register_2, Register_3,
                        Register_4, Register_5, Register_6, Register_7,
                        Register_8, Register_9, Register_10, Register_11,
                        Register_12, Register_13, Register_14, Register_15,
                        Register_16, Register_17, Register_18, Register_19,
                        Register_20, Register_21, Register_22, Register_23,
                        Register_24, Register_25, Register_26, Register_27,
                        Register_28, Register_29, Register_30, Register_31,
    
    output wire [31:0] debug_RD1_stage2, debug_RD2_stage2,
                       debug_ALUresult_stage3, debug_WBdata_stage5,
    output wire [4:0] debug_RegDest_MEM, debug_RegDest_stage5,
    output wire [1:0] debug_forwarding_A, debug_forwarding_B

    );


    //output port
    wire [31:0] pc_current;
    wire [31:0] zero, at, v0, v1, a0, a1, a2, a3, t0, t1, t2, t3, t4, t5, t6, t7,
                s0, s1, s2, s3, s4, s5, s6, s7, t8, t9, k0, k1, gp, sp, fp, ra;

    //use IF_StageU0
    wire [31:0] pc_stage1;
    wire [31:0] inst_stage1;
    wire hazard_PCWrite;

    
    
    //use IFtoID_Register U1
    wire [31:0] pc_IFID;
    wire [31:0] inst_stage2;
    wire hazard_IF_ID_Write;
    
    
    //use ID_Stage U2x
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
    wire [31:0] EX_ReadData2_stage3;
    wire [31:0] Branch_Addr_stage3;
    wire [4:0] RegDest_stage3;
    
    wire [1:0] ForwardA_wire, ForwardB_wire;


    //use EXtoMEM_Register U7
    wire zero_stage4;
    wire [31:0] EXtoMEM_ReadData2_stage4;
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
    wire [4:0] RegDest_stage5;



    
    
    IF_Stage U0 (
        .clk(clk),
        .rst(rst),
        .PCWrite(hazard_PCWrite),
        .PCSrc(PCSrc_stage4),
        .Branch(Branch_Addr_stage4),
        .IFtoID_PC(pc_stage1),
        .IFtoID_inst(inst_stage1),
        .PC_current(pc_current)
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
        .writeReg(RegDest_stage5),
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
        .funct(funct_stage2),
        .output_0(zero), .output_1(at), .output_2(v0), .output_3(v1), .output_4(a0), .output_5(a1),
        .output_6(a2), .output_7(a3), .output_8(t0), .output_9(t1), .output_10(t2), .output_11(t3),
        .output_12(t4), .output_13(t5), .output_14(t6), .output_15(t7), .output_16(s0), .output_17(s1),
        .output_18(s2), .output_19(s3), .output_20(s4), .output_21(s5), .output_22(s6), .output_23(s7),
        .output_24(t8), .output_25(t9), .output_26(k0), .output_27(k1), .output_28(gp), .output_29(sp),
        .output_30(fp), .output_31(ra)
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
    .WB_ALUresult(WriteData_stage5),
    
    // forwarding control
    .ForwardA(ForwardA_wire), .ForwardB(ForwardB_wire),
    
    // datapath output
    .zero(zero_stage3),
    .ALUresult(ALUresult_stage3),
    .EX_ReadData2(EX_ReadData2_stage3),
    .Branch_Addr(Branch_Addr_stage3), // computed branch address
//    output wire [31:0] Jump_address, // computed jump address
    .RegDest(RegDest_stage3) // Write data destination
);
    
        
    
    EXtoMEM_Register U7 (
    .clk(clk), .rst(rst),
    
    // datapath input
    .EX_zero(zero_stage3),
    .EX_ALUresult(ALUresult_stage3),
    .EX_ReadData2(EX_ReadData2_stage3),
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
    .EXtoMEM_ReadData2(EXtoMEM_ReadData2_stage4),
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
    .EX_MEM_Rd(RegDest_MEM), .MEM_WB_Rd(RegDest_stage5),
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
    .EXtoMEM_ReadData2(EXtoMEM_ReadData2_stage4),
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
    .WB_RegDest(RegDest_stage5)
    );


    assign ProgramCounter_Output = pc_current;
    assign Register_0 = zero;
    assign Register_1 = at;    
    assign Register_2 = v0;
    assign Register_3 = v1;
    assign Register_4 = a0;
    assign Register_5 = a1;    
    assign Register_6 = a2;
    assign Register_7 = a3;
    assign Register_8 = t0;
    assign Register_9 = t1;    
    assign Register_10 = t2;
    assign Register_11 = t3;
    assign Register_12 = t4;
    assign Register_13 = t5;    
    assign Register_14 = t6;
    assign Register_15 = t7;
    assign Register_16 = s0;
    assign Register_17 = s1;    
    assign Register_18 = s2;
    assign Register_19 = s3;
    assign Register_20 = s4;
    assign Register_21 = s5;    
    assign Register_22 = s6;
    assign Register_23 = s7;
    assign Register_24 = t8;
    assign Register_25 = t9;    
    assign Register_26 = k0;
    assign Register_27 = k1;
    assign Register_28 = gp;
    assign Register_29 = sp;    
    assign Register_30 = fp;
    assign Register_31 = ra;
    
    assign debug_RD1_stage2 = readData1_stage2;
    assign debug_RD2_stage2 = readData2_stage2;
    assign debug_ALUresult_stage3 = ALUresult_stage3;
    assign debug_WBdata_stage5 = WriteData_stage5;
    assign debug_RegDest_MEM = RegDest_MEM;
    assign debug_RegDest_stage5 = RegDest_stage5;
    assign debug_forwarding_A = ForwardA_wire;
    assign debug_forwarding_B = ForwardB_wire;

endmodule
