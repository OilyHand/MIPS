module DataMemoryUnit(
    input wire clk,                // 클럭 신호
    input wire memWrite,           // 메모리에 쓸지 여부
    input wire memRead,            // 메모리에서 읽을지 여부
    input wire [31:0] address,     // 메모리 주소
    input wire [31:0] writeData,   // 메모리에 쓸 데이터
    output reg [31:0] readData     // 메모리에서 읽은 데이터
);

    reg [31:0] memory [0:1023];     // 1024개의 32비트 메모리 위치

    always @(posedge clk) begin
        if (memWrite) begin
            // 메모리 쓰기 동작
            memory[address] <= writeData;
        end
        if (memRead) begin
            // 메모리 읽기 동작
            readData <= memory[address];
        end
    end

endmodule
