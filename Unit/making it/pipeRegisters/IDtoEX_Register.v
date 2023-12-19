module IDtoEX_Register(
    input wire clk,
    input wire rst,
    
    //input from ID_Stage
    input wire [31:0] ID_ReadData1, ID_ReadData2,
    input wire [31:0] ID_Imm,
    input wire [4:0] ID_Rs, ID_Rt, ID_Rd,
    input wire [5:0] funct,
 
 
    //input from Control
    input wire [1:0] ALUOp,
    input wire ALUSrc, RegDst, MemRead, MemWrite, RegWrite, MemtoReg,
 
 
    // outputs to EX_Stage
    output reg [31:0] IDtoEX_ReadData1,IDtoEX_ReadData2, // Read Data from Register File
    output reg [31:0] IDtoEX_Imm, // Sign extended immediate value
    output reg [4:0] IDtoEX_Rt, IDtoEX_Rd, // Destination Register

    // Control unit to use in 3 stage
    output reg [1:0] EX_ALUOp,
    output reg EX_ALUSrc,
    output reg EX_RegDst,
    

    // outputs to Forwarding unit
    output reg [4:0] Forwarding_Rs,
    
    
    // outputs to ALU control 
    output reg [5:0] ALUcontrol_funct, // Function code
    
    // outputs to next pipe
    output reg IDtoEX_MemRead, IDtoEX_MemWrite,     // stage 4?????? ??????
    output reg IDtoEX_RegWrite, IDtoEX_MemtoReg      // stage 5?????? ??????
    );
    
    always @ (posedge clk or posedge rst) begin
    if (rst) begin 
        IDtoEX_ReadData1 <= 0;
        IDtoEX_ReadData2 <= 0;
        IDtoEX_Imm <= 0;
        IDtoEX_Rt <= 0;
        IDtoEX_Rd <= 0;
        Forwarding_Rs <= 0;
        ALUcontrol_funct <= 0;
        EX_ALUOp <= 0;
        EX_ALUSrc <= 0;
        EX_RegDst <= 0;
        IDtoEX_MemRead <= 0;
        IDtoEX_MemWrite <= 0;
        IDtoEX_RegWrite <= 0;
        IDtoEX_MemtoReg <= 0;
    end
    else begin
        IDtoEX_ReadData1 <= ID_ReadData1;
        IDtoEX_ReadData2 <= ID_ReadData2;
        IDtoEX_Imm <= ID_Imm;
        IDtoEX_Rt <= ID_Rt;
        IDtoEX_Rd <= ID_Rd;
        EX_ALUOp <= ALUOp;
        EX_ALUSrc <= ALUSrc;
        EX_RegDst <= RegDst;
        Forwarding_Rs <= ID_Rs;
        ALUcontrol_funct <= funct;
        IDtoEX_MemRead <= MemRead;
        IDtoEX_MemWrite <= MemWrite;
        IDtoEX_RegWrite <= RegWrite;
        IDtoEX_MemtoReg <= MemtoReg;
    end
  end
endmodule
