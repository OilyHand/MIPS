module Forward_Unit(
    input [4:0] EX_MEM_Rd, MEM_WB_Rd,
    input [4:0] ID_EX_Rs, ID_EX_Rt,
    input MEM_WB_RegWrite, EX_MEM_RegWrite,
    output reg [1:0] ForwardA, ForwardB
    );

    always @*
    begin
        // Default is 0 (not forwarding)
        ForwardA = 2'b00; ForwardB = 2'b00;
        
        // EX harzard
        if(EX_MEM_RegWrite && (EX_MEM_Rd != 32'd0)) begin
            if(EX_MEM_Rd == ID_EX_Rs)
                ForwardA = 2'b10;
            if(EX_MEM_Rd == ID_EX_Rt)
                ForwardB = 2'b10;
        end
        
        // MEM hazard
        if(MEM_WB_RegWrite && (MEM_WB_Rd != 32'd0)) begin
            if((MEM_WB_Rd == ID_EX_Rs) && !((EX_MEM_RegWrite) && (EX_MEM_Rd != 32'd0) && (EX_MEM_Rd == ID_EX_Rs)))
                ForwardA = 2'b01;
            if((MEM_WB_Rd == ID_EX_Rt) && !((EX_MEM_RegWrite) && (EX_MEM_Rd != 32'd0) && (EX_MEM_Rd == ID_EX_Rt)))
                ForwardB = 2'b01;
        end
        
    end
endmodule
