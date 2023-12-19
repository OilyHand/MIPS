module ID_Stage(
    input wire clk,
    input wire rst,
    input wire [31:0] IFtoID_PC,
    input wire [31:0] IFtoID_inst,
    input wire [4:0] writeReg,
    input wire [31:0] writeData,
    input wire RegWrite,
    
    output wire [31:0] IDtoEX_ReadData1, 
    output wire [31:0] IDtoEX_ReadData2,
    output wire [31:0] IDtoEX_Imm,
    output wire [5:0] IFtoID_Op,    //31:26
    output wire [4:0] IFtoID_Rs,    //25:21
    output wire [4:0] IFtoID_Rt,    //20:16
    output wire [4:0] IFtoID_Rd,    //15:11
    output wire [5:0] funct,
    output wire [31:0] Branch_Addr,
    output wire branch_equal,
    
    output wire [31:0] output_0, output_1, output_2, output_3, output_4, output_5, output_6, output_7, output_8,
                       output_9, output_10, output_11, output_12, output_13, output_14, output_15, output_16, output_17, output_18,
                       output_19, output_20, output_21, output_22, output_23, output_24, output_25, output_26, output_27, output_28,
                       output_29, output_30, output_31
);
    // Register File
    wire [31:0] RD1, RD2, zero, at, v0, v1, a0, a1, a2, a3, t0, t1, t2, t3, t4, t5, t6, t7,
                s0, s1, s2, s3, s4, s5, s6, s7, t8, t9, k0, k1, gp, sp, fp, ra;
    wire [4:0] RR1, RR2, WR;
    wire [31:0] WD;
    wire WriteReg;
    
    wire [31:0] imm; // using sign extension
    wire [31:0] sll_out;
    
    // Instruction Decode
    assign RR1 = IFtoID_inst[25:21];
    assign RR2 = IFtoID_inst[20:16];   
    assign WR = writeReg;
    assign WD = writeData;
    assign WriteReg = RegWrite;
    
    // calculate branch address
    Shifting SHIFT (.Din(imm), .shamt(5'd2), .left(1'b1), .Dout(sll_out));
    Adder ADD_addr (.operandA(IFtoID_PC), .operandB(sll_out), .sum(Branch_Addr));
    
    RegisterFile u0 (
        .RD1(RD1), .RD2(RD2),
        .zero(zero), .at(at), .v0(v0), .v1(v1), .a0(a0), .a1(a1), .a2(a2), .a3(a3),
        .t0(t0), .t1(t1), .t2(t2), .t3(t3), .t4(t4), .t5(t5), .t6(t6), .t7(t7),
        .s0(s0), .s1(s1), .s2(s2), .s3(s3), .s4(s4), .s5(s5), .s6(s6), .s7(s7),
        .t8(t8), .t9(t9), .k0(k0), .k1(k1), .gp(gp), .sp(sp), .fp(fp), .ra(ra),
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

    // register file output
    assign IDtoEX_ReadData1 = (WR == RR1)? WD:RD1;
    assign IDtoEX_ReadData2 = (WR == RR2)? WD:RD2;
    assign IDtoEX_Imm = imm;
    
    assign IFtoID_Op = IFtoID_inst[31:26];   
    assign IFtoID_Rs = IFtoID_inst[25:21];
    assign IFtoID_Rt = IFtoID_inst[20:16];
    assign IFtoID_Rd = IFtoID_inst[15:11];
    assign funct = IFtoID_inst[5:0];
    
    assign output_0 = zero;
    assign output_1 = at;   
    assign output_2 = v0;
    assign output_3 = v1;
    assign output_4 = a0;
    assign output_5 = a1;   
    assign output_6 = a2;
    assign output_7 = a3;
    assign output_8 = t0;
    assign output_9 = t1;   
    assign output_10 = t2;
    assign output_11 = t3;
    assign output_12 = t4;
    assign output_13 = t5;   
    assign output_14 = t6;
    assign output_15 = t7;
    assign output_16 = s0;
    assign output_17 = s1;   
    assign output_18 = s2;
    assign output_19 = s3;
    assign output_20 = s4;
    assign output_21 = s5;   
    assign output_22 = s6;
    assign output_23 = s7;
    assign output_24 = t8;
    assign output_25 = t9;   
    assign output_26 = k0;
    assign output_27 = k1;
    assign output_28 = gp;
    assign output_29 = sp;   
    assign output_30 = fp;
    assign output_31 = ra;
    
    assign branch_equal = (RD1 == RD2);
    
endmodule
