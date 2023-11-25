module InstructionMemory(
    input wire clk,               // 클럭 신호
    input wire [31:0] address,    // 명령어 주소
    output reg [31:0] instruction // 읽은 명령어
);

    reg [31:0] memory [0:1023];    // 1024개의 32비트 명령어 메모리 위치

    always @(posedge clk) begin
        // 주어진 주소에서 명령어 읽기
        instruction <= memory[address];
    end

    // 명령어 메모리 초기화 (프로젝트에 따라 필요할 수 있음)
    initial begin
        // 임의의 메모리 기입
        memory[0] = 32'h8c000001;  // lw $0, 1($0)
        memory[1] = 32'h20020002;  // add $0, $1, $2
    end

endmodule
