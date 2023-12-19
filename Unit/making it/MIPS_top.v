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
    
    output wire [31:0] memory_8, memory_12, memory_16, memory_20, 
    
    output wire [31:0] debug_1, debug_2, debug_3, debug_4,
                       debug_5, debug_6, debug_7,debug_8, debug_9
    );

//~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~~*~*~*~*~*~*~*~*~*~*~~*~*~*~~*~*~*~~*~*~*~~*~*~*~*~~*~*~*~*
    //output port
    wire [31:0] pc_current;
    wire [31:0] zero, at, v0, v1, a0, a1, a2, a3, t0, t1, t2, t3, t4, t5, t6, t7,
                s0, s1, s2, s3, s4, s5, s6, s7, t8, t9, k0, k1, gp, sp, fp, ra;


    //use U0 IF_Stage
    wire [31:0] pc_stage1;
    wire [31:0] inst_stage1;
    wire hazard_PCWrite;
    
    
    //use U1 IFID_Register
    wire [31:0] pc_IFID;
    wire [31:0] inst_stage2;
    wire hazard_IF_ID_Write;
    
    
    //use U2 ID_Stage
    wire [31:0] readData1_stage2;
    wire [31:0] readData2_stage2;
    wire [31:0] signExtended_stage2;
    wire [5:0] Op_stage2;
    wire [4:0] Rs_stage2, Rt_stage2, Rd_stage2;
    wire [5:0] funct_stage2;
    wire [31:0] Branch_Addr_stage2;
    wire branch_equal_stage2;
    
    
    //use U3 Control
    wire hazard_stall;
    wire [5:0] opcode;
    wire [1:0] Control_ALUOp;
    wire Control_ALUSrc, Control_RegDst, Control_Branch, Control_MemRead,
          Control_MemWrite, Control_RegWrite, Control_MemtoReg, Control_IF_Flush;


    //use U4 IDEX_Register
    wire [31:0] pc_stage3;
    wire [31:0] readData1_stage3;
    wire [31:0] readData2_stage3;
    wire [31:0] signExtended_stage3;
    wire [4:0] Rs_stage3, Rt_stage3, Rd_stage3;
    wire [5:0] funct_stage3;
    wire [1:0] IDtoEX_ALUOp;
    wire IDtoEX_ALUSrc, IDtoEX_RegDst, IDtoEX_MemRead, IDtoEX_MemWrite, IDtoEX_RegWrite, IDtoEX_MemtoReg;

    
    //use U6 EX_Stage
    wire [31:0] ALUresult_stage3;
    wire [31:0] EX_ReadData2_stage3;
    wire [4:0] RegDest_stage3;
    wire [1:0] ForwardA_wire, ForwardB_wire;


    //use U7 EXMEM_Register
    wire [31:0] EXtoMEM_ReadData2_stage4;
    wire [31:0] ALUresult_stage4;
    wire [4:0] RegDest_stage4;
    wire EXtoMEM_MemRead, EXtoMEM_MemWrite, EXtoMEM_RegWrite, EXtoMEM_MemtoReg;


    //use U9 MEM_Stage
    wire [31:0] MEM_ReadData_stage4;
    wire [31:0] ALUresult_MEM;
    wire [4:0] RegDest_MEM;
    wire [31:0] memory8, memory12, memory16, memory20;


    // use U10 MEMWB_Register
    wire [31:0] MEMtoWB_ReadData_stage5;
    wire [31:0] ALUresult_WB;
    wire [4:0] RegDest_WB;
    wire MEMtoWB_MemtoReg;
    wire MEMtoWB_RegWrite;
    
    
    // use U11 WB_Stage
    wire [31:0] WriteData_stage5;
    wire [4:0] RegDest_stage5;


//~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~~*~*~*~*~*~*~*~*~*~*~~*~*~*~~*~*~*~~*~*~*~~*~*~*~*~~*~*~*~* 
    IF_Stage U0 (
//input
        .clk(clk), .rst(rst),
        .PCWrite(hazard_PCWrite),
        .PCSrc(Control_Branch),
        .Branch(Branch_Addr_stage2),
//output
        .IFtoID_PC(pc_stage1),
        .IFtoID_inst(inst_stage1),
        .PC_current(pc_current)
    );


    IFtoID_Register U1 (
//input
        .clk(clk),
        .rst(rst),
        .IF_PC(pc_stage1),
        .IF_inst(inst_stage1),
        .IF_ID_Write(hazard_IF_ID_Write),
        .IF_Flush(Control_IF_Flush),
//output
        .ID_PC(pc_IFID),
        .ID_inst(inst_stage2)
    );


    ID_Stage U2 (
//input
        .clk(clk),
        .rst(rst),
        .IFtoID_PC(pc_IFID),
        .IFtoID_inst(inst_stage2),
        .writeReg(RegDest_stage5),
        .writeData(WriteData_stage5),
        .RegWrite(MEMtoWB_RegWrite),
//output
        .IDtoEX_ReadData1(readData1_stage2),
        .IDtoEX_ReadData2(readData2_stage2),
        .IDtoEX_Imm(signExtended_stage2),
        .IFtoID_Op(Op_stage2),
        .IFtoID_Rs(Rs_stage2),
        .IFtoID_Rt(Rt_stage2),
        .IFtoID_Rd(Rd_stage2),
        .funct(funct_stage2),
        .branch_equal(branch_equal_stage2),
        .Branch_Addr(Branch_Addr_stage2),
        
        .output_0(zero), .output_1(at), .output_2(v0), .output_3(v1), .output_4(a0), .output_5(a1),
        .output_6(a2), .output_7(a3), .output_8(t0), .output_9(t1), .output_10(t2), .output_11(t3),
        .output_12(t4), .output_13(t5), .output_14(t6), .output_15(t7), .output_16(s0), .output_17(s1),
        .output_18(s2), .output_19(s3), .output_20(s4), .output_21(s5), .output_22(s6), .output_23(s7),
        .output_24(t8), .output_25(t9), .output_26(k0), .output_27(k1), .output_28(gp), .output_29(sp),
        .output_30(fp), .output_31(ra)
    );


    Control U3 (
//input
        .rst(rst),
        .hazard_detected(hazard_stall),
        .opcode(Op_stage2),
        .branch_equal(branch_equal_stage2),
        .IF_PC(pc_stage1),
//output
        .ALUOp(Control_ALUOp),
        .ALUSrc(Control_ALUSrc),
        .RegDst(Control_RegDst),
        .MemRead(Control_MemRead),
        .MemWrite(Control_MemWrite),
        .RegWrite(Control_RegWrite),
        .MemtoReg(Control_MemtoReg),
        .Branch(Control_Branch),
        .IF_Flush(Control_IF_Flush)
    );


    IDtoEX_Register U4 (
//input
        .clk(clk), .rst(rst),
        .ID_ReadData1(readData1_stage2),
        .ID_ReadData2(readData2_stage2),
        .ID_Imm(signExtended_stage2),
        .ID_Rs(Rs_stage2),
        .ID_Rt(Rt_stage2),
        .ID_Rd(Rd_stage2),
        .funct(funct_stage2),
        .ALUOp(Control_ALUOp),
        .ALUSrc(Control_ALUSrc),
        .RegDst(Control_RegDst),
        .MemRead(Control_MemRead),
        .MemWrite(Control_MemWrite),
        .RegWrite(Control_RegWrite),
        .MemtoReg(Control_MemtoReg),
//outputs
        .IDtoEX_ReadData1(readData1_stage3),
        .IDtoEX_ReadData2(readData2_stage3),
        .IDtoEX_Imm(signExtended_stage3),
        .IDtoEX_Rt(Rt_stage3),
        .IDtoEX_Rd(Rd_stage3),
        .EX_ALUOp(IDtoEX_ALUOp),
        .EX_ALUSrc(IDtoEX_ALUSrc),
        .EX_RegDst(IDtoEX_RegDst),
        .Forwarding_Rs(Rs_stage3),
        .ALUcontrol_funct(funct_stage3),
        .IDtoEX_MemRead(IDtoEX_MemRead),
        .IDtoEX_MemWrite(IDtoEX_MemWrite),
        .IDtoEX_RegWrite(IDtoEX_RegWrite),
        .IDtoEX_MemtoReg(IDtoEX_MemtoReg)
    );
    
    
    Hazard_Detection U5 (
//input
        .ID_EX_MemRead(IDtoEX_MemRead),
        .ID_EX_Rt(Rt_stage3),
        .IF_ID_Rs(Rs_stage2),
        .IF_ID_Rt(Rt_stage2),
//output
        .PCWrite(hazard_PCWrite),
        .IF_ID_Write(hazard_IF_ID_Write),
        .Stall(hazard_stall)
    );
    
    
    EX_Stage U6 (
//input
        .IDtoEX_ReadData1(readData1_stage3),
        .IDtoEX_ReadData2(readData2_stage3),
        .IDtoEX_Imm(signExtended_stage3),
        .IDtoEX_Rt(Rt_stage3),
        .IDtoEX_Rd(Rd_stage3),
        .funct(funct_stage3),
        .ALUop(IDtoEX_ALUOp),
        .ALUSrc(IDtoEX_ALUSrc),
        .RegDst(IDtoEX_RegDst),
        .EXtoMEM_ALUresult(ALUresult_stage4),
        .WB_ALUresult(WriteData_stage5),
        .ForwardA(ForwardA_wire),
        .ForwardB(ForwardB_wire),
//output
        .ALUresult(ALUresult_stage3),
        .EX_ReadData2(EX_ReadData2_stage3),
        .RegDest(RegDest_stage3)
    );
    
    EXtoMEM_Register U7 (
//input
        .clk(clk),
        .rst(rst),
        .EX_ALUresult(ALUresult_stage3),
        .EX_ReadData2(EX_ReadData2_stage3),
        .EX_RegDest(RegDest_stage3),
        .EX_MemRead(IDtoEX_MemRead),
        .EX_MemWrite(IDtoEX_MemWrite),
        .EX_MemtoReg(IDtoEX_MemtoReg),
        .EX_RegWrite(IDtoEX_RegWrite),
//output
        .EXtoMEM_ALUresult(ALUresult_stage4),
        .EXtoMEM_ReadData2(EXtoMEM_ReadData2_stage4),
        .EXtoMEM_RegDest(RegDest_stage4),
        .MEM_MemRead(EXtoMEM_MemRead),
        .MEM_MemWrite(EXtoMEM_MemWrite),
        .MEM_MemtoReg(EXtoMEM_MemtoReg),
        .MEM_RegWrite(EXtoMEM_RegWrite)
    );

    Forward_Unit U8 (
//input
        .EX_MEM_Rd(RegDest_MEM),
        .MEM_WB_Rd(RegDest_stage5),
        .ID_EX_Rs(Rs_stage3),
        .ID_EX_Rt(Rt_stage3),
        .MEM_WB_RegWrite(MEMtoWB_RegWrite),
        .EX_MEM_RegWrite(EXtoMEM_RegWrite),
//output
        .ForwardA(ForwardA_wire),
        .ForwardB(ForwardB_wire)
    );



    MEM_Stage U9 (
//input
        .clk(clk),
        .EXtoMEM_ALUresult(ALUresult_stage4),
        .EXtoMEM_ReadData2(EXtoMEM_ReadData2_stage4),
        .EXtoMEM_RegDest(RegDest_stage4),
        .MemWrite(EXtoMEM_MemWrite),
        .MemRead(EXtoMEM_MemRead),
//output
        .MEM_ReadData(MEM_ReadData_stage4),
        .MEM_ALU_result(ALUresult_MEM),
        .MEM_RegDest(RegDest_MEM),
        .output_memory8(memory8),
        .output_memory12(memory12),
        .output_memory16(memory16),
        .output_memory20(memory20)
    );
    
    MEMtoWB_Register U10 (
//input
        .clk(clk),
        .rst(rst),
        .MEM_ReadData(MEM_ReadData_stage4),
        .MEM_ALU_result(ALUresult_MEM),
        .MEM_RegDest(RegDest_MEM),
        .MEM_MemtoReg(EXtoMEM_MemtoReg),
        .MEM_RegWrite(EXtoMEM_RegWrite),
        .MEMtoWB_ReadData(MEMtoWB_ReadData_stage5),
        .MEMtoWB_ALU_result(ALUresult_WB),
        .MEMtoWB_RegDest(RegDest_WB),
 //output
        .MEMtoWB_MemtoReg(MEMtoWB_MemtoReg),
        .MEMtoWB_RegWrite(MEMtoWB_RegWrite)
    );

    WB_Stage U11 (
//input
        .MEMtoWB_ReadData(MEMtoWB_ReadData_stage5),
        .MEMtoWB_ALU_result(ALUresult_WB),
        .MEMtoWB_RegDest(RegDest_WB),
        .MemtoReg(MEMtoWB_MemtoReg),
//output
        .WB_WriteReg(WriteData_stage5),
        .WB_RegDest(RegDest_stage5)
    );
    
//~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~~*~*~*~*~*~*~*~*~*~*~~*~*~*~~*~*~*~~*~*~*~~*~*~*~*~~*~*~*~*
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
    
    assign memory_8 = memory8;
    assign memory_12 = memory12;
    assign memory_16 = memory16;
    assign memory_20 = memory20;
    
    assign debug_1 = RegDest_stage5;
    assign debug_2 = RegDest_MEM;
    assign debug_3 = RegDest_stage3;
    assign debug_4 = Rd_stage3;
    assign debug_5 = Rd_stage2;
    assign debug_6 = inst_stage2;
    assign debug_7 = inst_stage1;
    assign debug_8 = hazard_PCWrite;
    assign debug_9 = pc_stage1;

endmodule
