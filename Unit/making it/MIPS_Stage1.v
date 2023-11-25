module MIPS_Stage1(
    input wire clk,
    input wire rst,
    output reg [31:0] pc,
    output reg [31:0] inst  // 현재 명령어
);

  
    ProgramCounter U0 (
        .clk(clk),
        .branchAddress(0),
        .branch(0),
        .jumpAddress(0),
        .jump(0),
        .PCWriteValue(0),
        .PCWrite(1),  // PC 값
        .pc(pc)
    );

  
    // Instruction Memory (실제 메모리 대신 간단한 배열을 사용)
    reg [31:0] memory [0:255];  // 256개의 명령어 메모리
    initial begin
        // 메모리에 임의의 초기 명령어를 기입.
        memory[0] = 32'h8c000001;  // lw $0, 1($0)
        memory[1] = 32'h20020002;  // add $0, $1, $2
        // 더 많은 명령어를 추가가능
    end

    assign inst = memory[pc >> 2];  // 현재 주소에서 명령어를 읽습니다.


  
    Adder U1 (
        .operandA(pc),
        .operandB(4),  // 다음 명령어의 주소는 현재 주소 + 4
        .sum(pc)
    );

endmodule
