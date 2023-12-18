module ProgramCounter(
    input wire clk,        // ?ī?― ? ?ļ
    input wire rst,
    input wire PCSrc,
    input wire [31:0] PCWriteValue,  // PC? ?°?Žė§? ę°?
    input wire PCWrite,    // Control unit
    
    output reg [31:0] pc    // ??Ž PC ę°?
);

    always @(posedge clk, posedge rst) begin
        if (rst == 1)
            pc <= 0;
    
        else if (PCWrite)  // PCwrite Control unit?ī ??ą??ëĐ?
            pc <= PCWriteValue;  // ę·? ę°ėžëĄ? pc ?Ū?ī?°ęļ?
    end

endmodule
