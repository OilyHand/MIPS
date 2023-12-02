module EX_Stage(
    // inputs from ID/EX pipeline register
    input wire [31:0] IDtoEX_PC, // Program Counter
    input wire [31:0] IDtoEX_ReadData1,IDtoEX_ReadData2, // Read Data from Register File
    input wire [31:0] IDtoEX_Imm, // Sign extended immediate value
    input wire [31:0] IDtoEX_Rt, IDtoEX_Rd, // Destination Register
    input wire [5:0] funct, // Function code
    // Control inputs
    input wire [1:0] ALUop,
    input wire ALUSrc,
    input wire RegDst,
    // Forwarding inputs
    input wire [31:0] EXtoMEM_ALUresult,
    input wire [31:0] WB_ALUresult,
    // forwarding control
    input wire [1:0] ForwardA, ForwardB,
    // output
    output wire zero,
    output wire [31:0] ALUresult,
    output wire [31:0] EXtoMEM_Rt,
    output wire [31:0] Branch_Addr, // Computed branch address
    output wire [31:0] RegDest // Write data destination
    );
    
    wire [31:0] ALUSrc_out, SL2_out;
    wire [3:0]  ALUcontrol;
    wire [31:0] FWA_out, FWB_out;
    
    
    // Branch address computation (PC-relative) 
    Shifting shift_left2 (.Din(IDtoEX_Imm), .shamt(5'd2), .left(1'b1), .Dout(SL2_out));
    Adder add_address (.operandA(IDtoEX_PC), .operandB(SL2_out), .sum(Branch_Addr));
    
    // ALU Control
    ALU_Control alu_control (.ALUop(ALUop), .funct(funct), .ALUctrl(ALUcontrol));
    
    // ALU
    ALU alu (
        .operandA(FWA_out), .operandB(ALUSrc_out),
        .aluControl(ALUcontrol),
        .result(ALUresult),
        .zeroFlag(zero),
        .negativeFlag(/*None*/)
    );
    
    // ALU Source MUX
    Mux_2 mux_ALUSrc (.X0(FWB_out), .X1(IDtoEX_Imm), .sel(ALUSrc), .Y(ALUSrc_out));
    
    // Forward A
    Mux_4 mux_FWA (
        .X0(IDtoEX_ReadData1), .X1(WB_ALUresult), .X2(EXtoMEM_ALUresult), .X3(/*None*/),
        .sel(ForwardA),
        .Y(FWA_out)
    );
    
    // Forward B
    Mux_4 mux_FWB (
        .X0(IDtoEX_ReadData2), .X1(WB_ALUresult), .X2(EXtoMEM_ALUresult), .X3(/*None*/),
        .sel(ForwardB),
        .Y(FWB_out)
    );
    
    // Select Destination Register for writing data
    Mux_2 mux_RegDst (.X0(IDtoEX_Rt), .X1(IDtoEX_Rd), .sel(RegDst), .Y(RegDest));
    
    assign EXtoMEM_Rt = FWB_out;

endmodule
