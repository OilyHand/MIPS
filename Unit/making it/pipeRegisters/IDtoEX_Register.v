module IDtoEX_Register(
    input wire clk,
    input wire rst,
    
    //input from ID_Stage
    input wire [31:0] IFtoID_PC,
    input wire [31:0] IFtoID_ReadData1, IFtoID_ReadData2,
    input wire [31:0] IFtoID_Imm,
    input wire [4:0] IFtoID_Rs, IFtoID_Rt, IFtoID_Rd,
    input wire [5:0] funct,
 
 
    //input from Control
    input wire [1:0] ALUOp,
    input wire ALUSrc, RegDst, Branch, MemRead, MemWrite, RegWrite, MemtoReg, PCSrc,
 
 
    // outputs to EX_Stage
    output reg [31:0] IDtoEX_PC, // Program Counter
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
    output reg IDtoEX_Branch, IDtoEX_MemRead, IDtoEX_MemWrite,     // stage 4에서 사용
    output reg IDtoEX_RegWrite, IDtoEX_MemtoReg, IDtoEX_PCSrc      // stage 5에서 사용
    
    );
    
    always @ (posedge clk) begin
    if (rst) begin 
        IDtoEX_PC <= 0;
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
        
        IDtoEX_Branch <= 0;
        IDtoEX_MemRead <= 0;
        IDtoEX_MemWrite <= 0;
        IDtoEX_RegWrite <= 0;
        IDtoEX_MemtoReg <= 0;
        IDtoEX_PCSrc <= 0;
        
    end
    else begin
        IDtoEX_PC <= IFtoID_PC;
        IDtoEX_ReadData1 <= IFtoID_ReadData1;
        IDtoEX_ReadData2 <= IFtoID_ReadData2;
        IDtoEX_Imm <= IFtoID_Imm;
        IDtoEX_Rt <= IFtoID_Rt;
        IDtoEX_Rd <= IFtoID_Rd;
        
        EX_ALUOp <= ALUOp;
        EX_ALUSrc <= ALUSrc;
        EX_RegDst <= RegDst;
        
        Forwarding_Rs <= IFtoID_Rs;
        ALUcontrol_funct <= funct;
        
        IDtoEX_Branch <= Branch;
        IDtoEX_MemRead <= MemRead;
        IDtoEX_MemWrite <= MemWrite;
        IDtoEX_RegWrite <= RegWrite;
        IDtoEX_MemtoReg <= MemtoReg;
        IDtoEX_PCSrc <= PCSrc;
        
    end
  end
endmodule
