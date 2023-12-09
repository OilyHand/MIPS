module tb_ALU();
    
    reg [31:0] A, B;
    reg [3:0] ALU_control;
    wire [31:0] ALU_result;
    wire zero, negative;

    ALU alu (
        .operandA(A), 
        .operandB(B), 
        .aluControl(ALU_control),
        .result(ALU_result),
        .zeroFlag(zero),
        .negativeFlag(negative)
    );

    initial begin
    #0
        ALU_control = 4'b0010; // add
        A = 23; B = 67; // result = 90
    #1
        ALU_control = 4'b0110; // sub
        A = 23; B = 67; // result = -44
    #1
        ALU_control = 4'b0001; // or
        A = 32'b0011_0011_1100_1100_0011_0011_1100_1100;
        B = 32'b1100_1100_0101_0110_0000_0000_0011_0000;
       //result 1111_1111_1101_1110_0011_0011_1111_1100
    #1
        ALU_control = 4'b0000; // and
        A = 32'b0011_0011_1100_1100_0011_0011_1100_1100;
        B = 32'b1100_1100_0101_0110_0000_0000_0011_0000;
       //result 0000_0000_0100_0100_0000_0000_0000_0000
    #1
        ALU_control = 4'b1100; // nor
        A = 32'b0011_0011_1100_1100_0011_0011_1100_1100;
        B = 32'b1100_1100_0101_0110_0000_0000_0011_0000;
       //result 0000_0000_0010_0001_1100_1100_0000_0011
    #1
        ALU_control = 4'b0111; // slt
        A = 23; B = 42; // result = 1
    #1
        ALU_control = 4'b0111; // slt
        A = 72; B = 51; // result = 0
    #1
        $finish;
    end

endmodule