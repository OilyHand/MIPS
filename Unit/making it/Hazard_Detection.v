module Hazard_Detection(
    input ID_EX_MemRead,
    input [4:0] ID_EX_Rt, IF_ID_Rs, IF_ID_Rt, 
    output reg PCWrite, IF_ID_Write, Stall
    );
    
    always @*
        if(ID_EX_MemRead && (ID_EX_Rt == IF_ID_Rs) && (ID_EX_Rt == IF_ID_Rt)) begin
            PCWrite = 0; IF_ID_Write = 0; Stall = 1; 
        end
        else begin 
            PCWrite = 1; IF_ID_Write = 1; Stall = 0;
        end    
endmodule