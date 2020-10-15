`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 16:18:53
// Design Name: 
// Module Name: ACC
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


module ACC(
    input clk,
    input C16,
    input C8,
    input [15:0] ALU_output,
    output reg [15:0] ACC_output
    );
    
    always @(posedge clk)
    begin
        if(C8)
            ACC_output <= 0;
        else if(C16)
            ACC_output <= ALU_output;
    end
    
endmodule
