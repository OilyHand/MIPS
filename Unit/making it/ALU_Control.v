module ALU_Control(
    input wire [1:0] ALUop,
    input wire [5:0] funct,
    output reg [3:0] ALUctrl
    );
/*
    ALUop	Funct	        ALUcontrol
lw  0 0     X X X X X X	    0 0 1 0
sw	0 0	    X X X X X X	    0 0 1 0
beq	0 1	    X X X X X X	    0 1 1 0
add	1 0	    1 0 0 0 0 0	    0 0 1 0
sub	1 0	    1 0 0 0 1 0	    0 1 1 0
and	1 0	    1 0 0 1 0 0	    0 0 0 0
or	1 0	    1 0 0 1 0 1	    0 0 0 1
slt	1 0	    1 0 1 0 1 0	    0 1 1 1
*/

    always @(ALUop or funct) begin
      case (ALUop)
        2'b00: ALUctrl = 4'b0010; // lw, sw
        2'b01: ALUctrl = 4'b0110; // beq
        2'b10: if (funct == 6'b100000) // add
                   ALUctrl = 4'b0010;
               else if (funct == 6'b100010) // sub
                   ALUctrl = 4'b0110;
               else if (funct == 6'b100100) // and
                   ALUctrl = 4'b0000;
               else if (funct == 6'b100101) // or
                   ALUctrl = 4'b0001;
               else if (funct == 6'b101010) // slt
                   ALUctrl = 4'b0111;
        default: ALUctrl = 4'd0;
      endcase
    end
endmodule
