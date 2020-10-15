`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 15:29:50
// Design Name: 
// Module Name: ALU_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU_tb();
    reg CLK;
    reg signed[15:0] ACC;
    reg signed[15:0] BR;
    wire signed[15:0] Res;
    reg C14;                        // Gate BR->ALU
    reg C15;                       //  Gate ACC->ALU
    reg [6:0]Op;
    
    initial begin
        CLK = 1'b1;
        forever 
        #5 CLK = ~CLK;
    end  
    
     initial begin
            ACC = 0;
            BR = 0;
            #10 ACC =  16'h00ff;
            #10 BR = 16'hff00;
            #10 C14=1;  C15=1; Op=7'b1;     // ADD
            #20 Op=7'b000_0010;   //SUB
            #100 $finish;
    end    
    
    ALU U(
                .ACC_input(ACC),
                .BR_input(BR),
                .Op(Op),
                .C14(C14),
                .C15(C15),
                .ACC_output(Res)
    );
endmodule
