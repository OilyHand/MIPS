module ProgramCounter(
    input wire clk,        // 클락 신호
    
    input wire [31:0] PCWriteValue,  // PC에 쓰여질 값
    input wire PCWrite,    // Control unit
    
    output reg [31:0] pc    // 현재 PC 값
);

    always @(posedge clk) begin
        if (PCWrite)  // PCwrite Control unit이 활성화되면
            pc <= PCWriteValue;  // 그 값으로 pc 덮어쓰기
    end

endmodule
