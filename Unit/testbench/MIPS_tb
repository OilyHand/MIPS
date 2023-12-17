`timescale 1ns / 1ps

module MIPS_tb();
reg clk, rst;
wire [31:0] ProgramCounter_Output,
            zero, at, v0, v1, a0, a1, a2, a3, t0, t1, t2, t3, t4, t5, t6, t7,
            s0, s1, s2, s3, s4, s5, s6, s7, t8, t9, k0, k1, gp, sp, fp, ra,
            RD1_stage2, RD2_stage2, ALUresult_stage3, WBdata_stage5;
wire [4:0] RegDest_MEM, RegDest_stage5;
wire [1:0] forwarding_A, forwarding_B;

MIPS uut (.clk(clk), .rst(rst), .ProgramCounter_Output(ProgramCounter_Output),
    .Register_0(zero), .Register_1(at), .Register_2(v0), .Register_3(v1), 
    .Register_4(a0), .Register_5(a1), .Register_6(a2), .Register_7(a3), 
    .Register_8(t0), .Register_9(t1), .Register_10(t2), .Register_11(t3), 
    .Register_12(t4), .Register_13(t5), .Register_14(t6), .Register_15(t7), 
    .Register_16(s0), .Register_17(s1), .Register_18(s2), .Register_19(s3), 
    .Register_20(s4), .Register_21(s5), .Register_22(s6), .Register_23(s7), 
    .Register_24(t8), .Register_25(t9), .Register_26(k0), .Register_27(k1), 
    .Register_28(gp), .Register_29(sp), .Register_30(fp), .Register_31(ra), 
    
    .debug_RD1_stage2(RD1_stage2), .debug_RD2_stage2(RD2_stage2),
    .debug_ALUresult_stage3(ALUresult_stage3), .debug_WBdata_stage5(WBdata_stage5),
    .debug_RegDest_MEM(RegDest_MEM), .debug_RegDest_stage5(RegDest_stage5),
    .debug_forwarding_A(forwarding_A), .debug_forwarding_B(forwarding_B));

initial begin
    clk = 0;
    rst = 1;
    #5
    rst = 0;
    #200
    $finish;
end

always #5 clk <= ~clk;

endmodule
