module ALU(
    input wire [31:0] operandA,
    input wire [31:0] operandB,
    input wire [2:0]  aluControl, // ALU 동작을 제어하는 신호
    output reg [31:0] result,
    output reg zeroFlag,          // 결과가 0인지 여부를 나타내는 플래그
    output reg negativeFlag      // 결과가 음수인지 여부를 나타내는 플래그
);

    always @(operandA or operandB or aluControl) begin
        case (aluControl)
            3'b000: result = operandA + operandB; // 덧셈
            3'b001: result = operandA - operandB; // 뺄셈
            3'b010: result = operandA & operandB; // AND
            3'b011: result = operandA | operandB; // OR
            3'b100: result = operandA ^ operandB; // XOR
            // 다른 동작 추가 가능
            default: result = 32'h0; // 기본적으로 0으로 설정
        endcase

        // 결과가 0인지 여부 확인
        zeroFlag = (result == 32'h0);

        // 결과가 음수인지 여부 확인
        negativeFlag = (result[31] == 1);
    end

endmodule
