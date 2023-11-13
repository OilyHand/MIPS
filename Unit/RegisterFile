///////////////////////////////////////////////////////////////////////////////
// Module Name: RegisterFile
// Description: 
//
// Ports: 
//   - RD1, RD2: Read Data 1, Read Data 2
//   - RR!, RR2: Read Register 1, Read Register 2
//   - WR: Write Register
//   - WD: Write Data
//   - WriteReg: WriteReg control signal
//   - clk: clock
///////////////////////////////////////////////////////////////////////////////

module RegisterFile(RD1, RD2, RR1, RR2, WR, WD, WriteReg, clk);
    output [31:0] RD1, RD2;
    input [4:0] RR1, RR2, WR; 
    input [31:0] WD;
    input clk, WriteReg; // control signal
    
    wire [31:0] WSel;
    wire [31:0] Q [31:0];
    
    Decoder_5to32   U0 (.Y(WSel), .X(WR), .En(WriteReg));
           Mux_32   U1 (.Y(RD1), .Sel(RR1), 
                        .X0(Q[0]),   .X1(Q[1]),   .X2(Q[2]),   .X3(Q[3]), 
                        .X4(Q[4]),   .X5(Q[5]),   .X6(Q[6]),   .X7(Q[7]),
                        .X8(Q[8]),   .X9(Q[9]),   .X10(Q[10]), .X11(Q[11]), 
                        .X12(Q[12]), .X13(Q[13]), .X14(Q[14]), .X15(Q[15]), 
                        .X16(Q[16]), .X17(Q[17]), .X18(Q[18]), .X19(Q[19]), 
                        .X20(Q[20]), .X21(Q[21]), .X22(Q[22]), .X23(Q[23]),
                        .X24(Q[24]), .X25(Q[25]), .X26(Q[26]), .X27(Q[27]), 
                        .X28(Q[28]), .X29(Q[29]), .X30(Q[30]), .X31(Q[31])
                       );
                        
           Mux_32   U2 (.Y(RD2), .Sel(RR2),
                        .X0(Q[0]),   .X1(Q[1]),   .X2(Q[2]),   .X3(Q[3]),
                        .X4(Q[4]),   .X5(Q[5]),   .X6(Q[6]),   .X7(Q[7]),
                        .X8(Q[8]),   .X9(Q[9]),   .X10(Q[10]), .X11(Q[11]),
                        .X12(Q[12]), .X13(Q[13]), .X14(Q[14]), .X15(Q[15]), 
                        .X16(Q[16]), .X17(Q[17]), .X18(Q[18]), .X19(Q[19]),
                        .X20(Q[20]), .X21(Q[21]), .X22(Q[22]), .X23(Q[23]),
                        .X24(Q[24]), .X25(Q[25]), .X26(Q[26]), .X27(Q[27]),
                        .X28(Q[28]), .X29(Q[29]), .X30(Q[30]), .X31(Q[31])
                       );
    
    dff Reg0  (.Q(Q[0]),  .D(WD),  .En(WSel[0]), .clk(clk));
    dff Reg1  (.Q(Q[1]),  .D(WD),  .En(WSel[1]), .clk(clk));
    dff Reg2  (.Q(Q[2]),  .D(WD),  .En(WSel[2]), .clk(clk));
    dff Reg3  (.Q(Q[3]),  .D(WD),  .En(WSel[3]), .clk(clk));
    dff Reg4  (.Q(Q[4]),  .D(WD),  .En(WSel[4]), .clk(clk));
    dff Reg5  (.Q(Q[5]),  .D(WD),  .En(WSel[5]), .clk(clk));
    dff Reg6  (.Q(Q[6]),  .D(WD),  .En(WSel[6]), .clk(clk));
    dff Reg7  (.Q(Q[7]),  .D(WD),  .En(WSel[7]), .clk(clk));
    dff Reg8  (.Q(Q[8]),  .D(WD),  .En(WSel[8]), .clk(clk));
    dff Reg9  (.Q(Q[9]),  .D(WD),  .En(WSel[9]), .clk(clk));
    dff Reg10 (.Q(Q[10]), .D(WD),  .En(WSel[10]), .clk(clk));
    dff Reg11 (.Q(Q[11]), .D(WD),  .En(WSel[11]), .clk(clk));
    dff Reg12 (.Q(Q[12]), .D(WD),  .En(WSel[12]), .clk(clk));
    dff Reg13 (.Q(Q[13]), .D(WD),  .En(WSel[13]), .clk(clk));
    dff Reg14 (.Q(Q[14]), .D(WD),  .En(WSel[14]), .clk(clk));
    dff Reg15 (.Q(Q[15]), .D(WD),  .En(WSel[15]), .clk(clk));
    dff Reg16 (.Q(Q[16]), .D(WD),  .En(WSel[16]), .clk(clk));
    dff Reg17 (.Q(Q[17]), .D(WD),  .En(WSel[17]), .clk(clk));
    dff Reg18 (.Q(Q[18]), .D(WD),  .En(WSel[18]), .clk(clk));
    dff Reg19 (.Q(Q[19]), .D(WD),  .En(WSel[19]), .clk(clk));
    dff Reg20 (.Q(Q[20]), .D(WD),  .En(WSel[20]), .clk(clk));
    dff Reg21 (.Q(Q[21]), .D(WD),  .En(WSel[21]), .clk(clk));
    dff Reg22 (.Q(Q[22]), .D(WD),  .En(WSel[22]), .clk(clk));
    dff Reg23 (.Q(Q[23]), .D(WD),  .En(WSel[23]), .clk(clk));
    dff Reg24 (.Q(Q[24]), .D(WD),  .En(WSel[24]), .clk(clk));
    dff Reg25 (.Q(Q[25]), .D(WD),  .En(WSel[25]), .clk(clk));
    dff Reg26 (.Q(Q[26]), .D(WD),  .En(WSel[26]), .clk(clk));
    dff Reg27 (.Q(Q[27]), .D(WD),  .En(WSel[27]), .clk(clk));
    dff Reg28 (.Q(Q[28]), .D(WD),  .En(WSel[28]), .clk(clk));
    dff Reg29 (.Q(Q[29]), .D(WD),  .En(WSel[29]), .clk(clk));
    dff Reg30 (.Q(Q[30]), .D(WD),  .En(WSel[30]), .clk(clk));
    dff Reg31 (.Q(Q[31]), .D(WD),  .En(WSel[31]), .clk(clk));
endmodule
