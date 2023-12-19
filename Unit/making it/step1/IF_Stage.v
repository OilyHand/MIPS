module IF_Stage(
        input wire clk,
        input wire rst,
        
        input wire PCWrite,
        input wire PCSrc,
        input wire [31:0] Branch,
        
        output wire [31:0] IFtoID_PC,
        output wire [31:0] IFtoID_inst,
        
        output wire [31:0] PC_current
    );
        wire [31:0] add_result;
        wire [31:0] Branch_value;
        
        wire ID_PCSrc;
        
        wire [31:0] MuxtoPC;
        wire [31:0] PCtoInst;
        
        assign Branch_value = Branch;
        assign ID_PCSrc = PCSrc;
  
        Mux_2 u0 (
            .X0(add_result),
            .X1(Branch_value),
            .sel(ID_PCSrc),
            .Y(MuxtoPC)
        );
    
    
        ProgramCounter u1 (
            .clk(clk), .rst(rst),
            .PCWriteValue(MuxtoPC),
            .PCWrite(PCWrite),
            .pc(PCtoInst) // 중간 변수에 연결
        );
    
    
        Adder u2 (
            .operandA(PCtoInst),
            .operandB(4),
            .sum(add_result)
        );
    
    
        InstructionMemory u3 (
            .clk(clk),
            .address(PCtoInst),
            .instruction(IFtoID_inst)
        );
        
        assign IFtoID_PC = add_result;
        assign PC_current = PCtoInst;
    
    endmodule
