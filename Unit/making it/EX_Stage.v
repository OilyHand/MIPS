module EX_Stage(
    input [31:0] IDtoEX_PC, // Program Counter
    input [31:0] IDtoEX_ReadData1,IDtoEX_ReadData2, // Read Data from Register File 
    input [31:0] IDtoEX_Imm, // Sign extended immediate value
    input [31:0] IDtoEX_Rt, IDtoEX_Rd, // Destination Register
    input [1:0] ForwardA, ForwardB, // Forwarding control
// need to add control signals
    output reg zero,
    output reg [31:0] ALU_result,
    output reg [31:0] EXtoMEM_Rt,
    output reg [31:0] Branch_Addr, // Computed branch address
    output reg [31:0] RegDest // Write data destination
    );
    
    // ALU Control
    
    // ALU
    
    // ALU Source MUX
    
    // Forward MUX

endmodule
