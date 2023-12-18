module InstructionMemory(
    input wire clk,           
    input wire [31:0] address,
    output reg [31:0] instruction
);

    reg [7:0] memory [0:1023];
    
    always @(posedge clk) begin
        instruction <= {memory[address], memory[address+1], memory[address+2], memory[address+3]};
    end


    initial begin
        memory[0] = 8'b00100001;
        memory[1] = 8'b00001000;
        memory[2] = 8'b00000000;
        memory[3] = 8'b00001000;     // addi $t0, $t0, 8
        //001000 01000 01000 0000000000001000
        memory[4] = 8'b00100001;
        memory[5] = 8'b00101001;
        memory[6] = 8'b00000000;
        memory[7] = 8'b00001000;     // addi $t1, $t1, 8
        //001000 01001 01001 0000000000001000    
        memory[8] = 8'b00010001;
        memory[9] = 8'b00001001;
        memory[10] = 8'b00000000;
        memory[11] = 8'b01100100;     // beq $t0, $t1, 100
        //000100 01000 01001 0000000001100100
        memory[12] = 8'b00000001;
        memory[13] = 8'b00101000;
        memory[14] = 8'b01011000;
        memory[15] = 8'b00100000;    // add $t3, $t1, $t0
        //000000 01001 01000 01011 00000 100000
        memory[16] = 8'b00000001;
        memory[17] = 8'b00101001;
        memory[18] = 8'b01011000;
        memory[19] = 8'b00100000;    // add $t3, $t1, $t1
        //000000 01001 01001 01011 00000 100000
        memory[416] = 8'b00000001;
        memory[417] = 8'b00101000;
        memory[418] = 8'b01010000;
        memory[419] = 8'b00100000;   // add $t2, $t1, $t0
        //000000 01001 01000 01010 00000 100000
        memory[420] = 8'b00100001;
        memory[421] = 8'b00001000;
        memory[422] = 8'b00000000;
        memory[423] = 8'b00001111;       // addi $t0, $t0, 15
        //001000 01000 01000 0000000000001000
        memory[424] = 8'b00100001;
        memory[425] = 8'b00101001;
        memory[426] = 8'b00000000;
        memory[427] = 8'b00000101;       // addi $t1, $t1, 5
        //001000 01001 01001 0000000000001000  
        memory[428] = 8'b00000001;
        memory[429] = 8'b00101000;
        memory[430] = 8'b01010000;
        memory[431] = 8'b00101010;      // slt $t2, $t1, $t0
        //000000 01001 01000 01010 00000 101010
        
    end

endmodule
