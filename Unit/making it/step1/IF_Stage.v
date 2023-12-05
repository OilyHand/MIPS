// synthesis, Implementation 통과

module IF_Stage(
    input wire clk,
    input wire rst,
    output wire [31:0] IFtoID_PC,
    output wire [31:0] IFtoID_inst
);
    reg [31:0] pc_reg; // 중간 변수 추가
    wire [31:0] add_result;

    ProgramCounter u0 (
        .clk(clk),
        .branchAddress(0),
        .branch(0),
        .jumpAddress(0),
        .jump(0),
        .PCWriteValue(0), // pc를 control과 연결하지 않을 경우 빼기
        .PCWrite(1),
        .pc(IFtoID_PC) // 중간 변수에 연결
    );

    Adder u2 (
        .operandA(IFtoID_PC),
        .operandB(4),
        .sum(add_result)
    );

    InstructionMemory u1 (
        .clk(clk),
        .address(IFtoID_PC),
        .instruction(IFtoID_inst)
    );
    

    always @(posedge clk or posedge rst) begin // negedge rst 사용하는 것도 고려해보기
        if (rst) begin
            // 리셋 신호가 활성화되면 초기값으로 리셋
            pc_reg <= 32'h0;
        end else begin
            // 리셋이 아니면 PC 값을 업데이트
            pc_reg <= u2.sum;
        end
    end
    
    assign IFtoID_PC = pc_reg;


endmodule
