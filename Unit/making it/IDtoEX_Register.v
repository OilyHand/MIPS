module IDtoEX_Register(
    input wire clk,
    input wire rst,
    input wire [31:0] IFtoID_PC,
    input wire [31:0] IFtoID_ReadData1,
    input wire [31:0] IFtoID_ReadData2,
    input wire [31:0] IFtoID_Imm,
    input wire [4:0] IFtoID_Rs,
    input wire [4:0] IFtoID_Rt,
    input wire [4:0] IFtoID_Rd,
 
 
    // outputs from ID/EX pipeline register
    output wire [31:0] IDtoEX_PC, // Program Counter
    output wire [31:0] IDtoEX_ReadData1,IDtoEX_ReadData2, // Read Data from Register File
    output wire [31:0] IDtoEX_Imm, // Sign extended immediate value
    output wire [31:0] IDtoEX_Rt, IDtoEX_Rd, // Destination Register
    output wire [5:0] funct, // Function code
    // Control inputs
    output wire [1:0] ALUop,
    output wire ALUSrc,
    output wire RegDst,
    // Forwarding inputs
    output wire [31:0] EXtoMEM_ALUresult,
    output wire [31:0] WB_ALUresult,
    // forwarding control
    output wire [1:0] ForwardA, ForwardB
    );
endmodule
