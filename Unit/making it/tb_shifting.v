`timescale 1ns / 1ps

module tb_shifting();
    reg [31:0] X;
    reg [4:0] shamt;
    reg left;
    wire [31:0] Y;
    
    Shifting uut (.Din(X), .shamt(shamt), .left(left), .Dout(Y));
    
    initial begin
        X = 32'b00001111_11110000_11110000_00001111;
        shamt = 5'd4;
        left = 1;
        #1
        X = 32'b00001111_11110000_11110000_00001111;
        shamt = 5'd4;
        left = 0;
        #1
        X = 32'b00100100_00110100_01010101_00011000;
        shamt = 5'd2;
        left = 1;
        #1
        $stop;
        
        
    
    end

endmodule
