`timescale 1ns / 1ps

module MIPS_tb();
reg clk, rst;
wire [31:0] ProgramCounter_Output,
            zero, at, v0, v1, a0, a1, a2, a3, t0, t1, t2, t3, t4, t5, t6, t7,
            s0, s1, s2, s3, s4, s5, s6, s7, t8, t9, k0, k1, gp, sp, fp, ra,
            m8, m12, m16, m20,
            d1, d2, d3, d4, d5, d6, d7, d8, d9;

MIPS uut (.clk(clk), .rst(rst), .ProgramCounter_Output(ProgramCounter_Output),
    .Register_0(zero), .Register_1(at), .Register_2(v0),  .Register_3(v1), 
    .Register_4(a0),   .Register_5(a1), .Register_6(a2),  .Register_7(a3), 
    .Register_8(t0),   .Register_9(t1), .Register_10(t2), .Register_11(t3), 
    .Register_12(t4), .Register_13(t5), .Register_14(t6), .Register_15(t7), 
    .Register_16(s0), .Register_17(s1), .Register_18(s2), .Register_19(s3), 
    .Register_20(s4), .Register_21(s5), .Register_22(s6), .Register_23(s7), 
    .Register_24(t8), .Register_25(t9), .Register_26(k0), .Register_27(k1), 
    .Register_28(gp), .Register_29(sp), .Register_30(fp), .Register_31(ra), 
    
    .memory_8(m8), .memory_12(m12), .memory_16(m16), .memory_20(m20), 
    
    .debug_1(d1), .debug_2(d2), .debug_3(d3), .debug_4(d4),
    .debug_5(d5), .debug_6(d6), .debug_7(d7),
    .debug_8(d8), .debug_9(d9));

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
