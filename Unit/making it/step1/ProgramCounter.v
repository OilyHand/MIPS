module ProgramCounter(
    input wire clk,        // ?Å¥?ùΩ ?ã†?ò∏
    input wire rst,
    input wire PCSrc,
    input wire [31:0] PCWriteValue,  // PC?óê ?ì∞?ó¨Ïß? Í∞?
    input wire PCWrite,    // Control unit
    
    output reg [31:0] pc    // ?òÑ?û¨ PC Í∞?
);

    always @(posedge clk, posedge rst) begin
        if (rst == 1)
            pc <= 0;
    
        else if (PCWrite)  // PCwrite Control unit?ù¥ ?ôú?Ñ±?ôî?êòÎ©?
            pc <= PCWriteValue;  // Í∑? Í∞íÏúºÎ°? pc ?çÆ?ñ¥?ì∞Í∏?
    end

endmodule
