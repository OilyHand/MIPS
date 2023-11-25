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

  
    InstructionMemory U1 (
        .clk(clk),
        .address(pc),
        .instruction(inst)
    );


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // 리셋 신호가 활성화되면 초기값으로 리셋
            pc <= 32'h0;
        end else begin
            // 리셋이 아니면 PC 값을 업데이트
            pc <= U0.pc;
        end
    end

endmodule


