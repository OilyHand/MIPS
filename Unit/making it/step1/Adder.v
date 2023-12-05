module Adder(
    input wire [31:0] operandA, // 피연산자 A
    input wire [31:0] operandB, // 피연산자 B
    output wire [31:0] sum       // 덧셈 결과
);

    assign sum = operandA + operandB;

endmodule
