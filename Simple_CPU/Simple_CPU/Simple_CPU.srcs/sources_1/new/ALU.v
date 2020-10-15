`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 14:16:54
// Design Name: 
// Module Name: ALU
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


module ALU(
    input  signed [15:0] ACC_input,     // Input from ACC
    input  signed [15:0] BR_input,        // Input from BR
    input  signed [3:0] Op,                // Define Operation
    input C14,                        // Gate BR->ALU
    input C15,                       //  Gate ACC->ALU
    output [2:0] flag,
    output signed [15:0] ACC_output,    // Output to AC 
	output signed [15:0] MR_output,
	output signed [15:0] DR_output
    );
    
   wire signed[15:0] ACC_reg = C15 ?  ACC_input : $signed(0);
   wire signed[15:0] BR_reg = C14 ?  BR_input : $signed(0);
   reg signed [15:0] res=0;
   reg [2:0] flag_reg=0;        //ZF SF OF
   (*dont_touch = "true" *) reg signed [31:0] MR=0;
   reg signed [15:0] DR=0;
    
    parameter  ADD=4'b0001,
                SUB = 4'b0010,
                MUL = 4'b0011,
                DIV = 4'b0100,
                AND = 4'b0101,
                OR = 4'b0110,
                XOR = 4'b0111,
                NOT_BR = 4'b1000,
                SRR = 4'b1001,
                SRL = 4'b1010,
                NOT_ACC = 4'b1011;
                
    always @(* )
    begin
        case(Op)
            ADD:begin
                res = ACC_reg + BR_reg;
                if(ACC_reg[15]==0 && BR_reg[15]==0 && res[15]==1) flag_reg[0]=1;
                else flag_reg[0]=0;
            end
            SUB:begin
                res = ACC_reg - BR_reg;
                if(ACC_reg[15]==1 && BR_reg[15]==1 && res[15]==0) flag_reg[0]=1;
                else flag_reg[0]=0;
            end
            MUL:begin
				MR = ACC_reg * BR_reg;
                res = MR[15:0];
                if(MR) flag_reg[0]=1; 
                else flag_reg[0]=0;
            end
            DIV:begin
				DR = ACC_reg % BR_reg;
                res = ACC_reg / BR_reg;
                flag_reg[0]=0;
            end
            AND:    res = ACC_reg & BR_reg;
            OR:       res = ACC_reg | BR_reg;
            XOR:    res = ACC_reg ^ BR_reg;
            NOT_BR:     res = ~BR_reg;
            NOT_ACC:     res = ~ACC_reg;
            SRL:      res = ACC_reg<< 1;
            SRR:      res = ACC_reg>>1;
        endcase
        if(res==0) flag_reg[2]=1;
        else flag_reg[2]=0;
        if(res[15]==1) flag_reg[1]=1;
        else flag_reg[1]=0;
    end
    
    assign ACC_output = res;
	assign MR_output = MR[31:16];
    assign DR_output = DR;
    assign flag = flag_reg;
endmodule
