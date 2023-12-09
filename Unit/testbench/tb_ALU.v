module tb_ALU();
    
    reg [31:0] A, B;
  	reg [5:0] funct;
  	reg [1:0] ALUOp;
    wire [3:0] ALU_control;
    wire [31:0] ALU_result;
    wire zero;

    ALU alu (
        .operandA(A), 
        .operandB(B), 
        .aluControl(ALU_control),
        .result(ALU_result),
        .zeroFlag(zero)
    );
  	
  	ALU_Control alu_ctrl (
      .ALUop(ALUOp),
      .funct(funct),
      .ALUctrl(ALU_control)
    );
  
    initial begin
    #0
        ALUOp = 2'b10; funct = 6'b100000; // add
        A = 23; B = 67; // result = 90
    #1
        ALUOp = 2'b10; funct = 6'b100010; // sub
        A = 23; B = 67; // result = -44
    #1
        ALUOp = 2'b10; funct = 6'b100101; // or
        A = 32'b0011_0011_1100_1100_0011_0011_1100_1100;
        B = 32'b1100_1100_0101_0110_0000_0000_0011_0000;
       //result 1111_1111_1101_1110_0011_0011_1111_1100
              //1111 1111 1101 1110 0011 0011 1111 1100
    #1
        ALUOp = 2'b10; funct = 6'b100100; // and
        A = 32'b0011_0011_1100_1100_0011_0011_1100_1100;
        B = 32'b1100_1100_0101_0110_0000_0000_0011_0000;
       //result 0000_0000_0100_0100_0000_0000_0000_0000
              //           100 0100 0000 0000 0000 0000
    #1
        ALUOp = 2'b10; funct = 6'b100111; // nor
        A = 32'b0011_0011_1100_1100_0011_0011_1100_1100;
        B = 32'b1100_1100_0101_0110_0000_0000_0011_0000;
       //result 0000_0000_0010_0001_1100_1100_0000_0011
    #1
        ALUOp = 2'b10; funct = 6'b101010;
        A = 23; B = 42; // result = 1
    #1
        A = 72; B = 51; // result = 0
    #1
        $finish;
    end

endmodule