module ProgramCounter(
    input wire clk,        // 클럭 신호
    input wire rst,        // 리셋 신호
    input wire [31:0] jumpAddress, // 분기 목적지 주소
    input wire branch,     // 분기 여부
    input wire branchCondition, // 분기 조건
    output reg [31:0] pc    // 프로그램 카운터 레지스터
);

    // 클럭 상승 에지에서 동작
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // 리셋 신호가 활성화되면 0으로 초기화
            pc <= 32'h0;
        end else if (branch && branchCondition) begin
            // 분기 신호가 활성화되고 분기 조건이 참이면 분기 주소로 업데이트
            pc <= jumpAddress;
        end else begin
            // 다음 주소로 증가
            pc <= pc + 4; // 명령어의 크기가 4바이트일 때
        end
    end

endmodule
