module DataMemoryUnit(
    input wire clk,
    input wire memWrite,
    input wire memRead,
    input wire [31:0] address,
    input wire [31:0] writeData,
    output reg [31:0] readData
);

    reg [7:0] memory [0:1023];

    always @(posedge clk) begin
        if (memWrite) begin
            memory[address] <= writeData[31:24];
            memory[address + 1] <= writeData[23:16];
            memory[address + 2] <= writeData[15:8];
            memory[address + 3] <= writeData[7:0];
        end
        if (memRead) begin
            readData <= {memory[address], memory[address + 1], memory[address + 2], memory[address + 3]};
        end
    end

endmodule
