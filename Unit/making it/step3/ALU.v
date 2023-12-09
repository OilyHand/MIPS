module ALU(
    input wire [31:0] operandA,
    input wire [31:0] operandB,
    input wire [3:0]  aluControl, // ALU 동작을 제어하는 신호
    output reg [31:0] result,
    output wire zeroFlag          // 결과가 0인지 여부를 나타내는 플래그
);
    always @(operandA or operandB or aluControl) begin
        casex (aluControl)
            4'b0000: result = operandA & operandB; // and
            4'b0001: result = operandA | operandB; // or
            4'b0010: result = operandA + operandB; // add
            4'b011x: begin 
                         result = operandA - operandB; // sub or slt
                         if(aluControl[0] == 1) // slt
                            if(operandA < operandB)
                                result = 32'd1;
                            else
                                result = 32'd0;
                     end 
            4'b1100: result = ~(operandA | operandB); // nor
            default: result = 32'h0;
        endcase
    end
    
    assign zeroFlag = (result == 32'h0);
endmodule
