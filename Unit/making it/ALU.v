module ALU(
    input wire [31:0] operandA,
    input wire [31:0] operandB,
    input wire [2:0]  aluControl, // ALU 동작을 제어하는 신호
    output reg [31:0] result,
    output reg zeroFlag,          // 결과가 0인지 여부를 나타내는 플래그
    output reg negativeFlag      // 결과가 음수인지 여부를 나타내는 플래그
);
    
// new version
// ALU control bit field -> ALUop = { ainvert, binvert, select[1], select[0] }
// select is result MUX select signal
// select == 2'b00 :: and gate to result
// select == 2'b01 :: or gate to result
// select == 2'b10 :: adder to result
// select == 2'b11 :: less to result

    always @(operandA or operandB or aluControl) begin
        casex (aluControl)
            4'b0000: result = operandA & operandB; // and
            4'b0001: result = operandA | operandB; // or
            4'b0010: result = operandA + operandB; // add
            4'b011x: begin 
                         result = operandA - operandB; // sub or slt
                         if(aluControl[1:0] == 2'b11) // slt
                            if(negativeFlag)
                                result = 32'd1;
                            else
                                result = 32'd0;
                     end 
            4'b1100: result = ~(operandA | operandB); // nor
            default: result = 32'h0;
        endcase
    end
    
    assign zeroFlag = (result == 32'h0);
    assign negativeFlag = (result[31] == 1);
    
endmodule
