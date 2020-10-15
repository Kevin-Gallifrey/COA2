`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 16:44:21
// Design Name: 
// Module Name: BR
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


module BR(
    input clk,
    input C7,
    input C9,
    input [15:0] MBR_ouput,
    output reg [15:0] BR_output
    );
    
    always @(posedge clk)
    begin
        if(C7)      // direct address
            BR_output = MBR_ouput;
        else if(C9)     //  immdeiate address
           BR_output = {8'b0000_0000,MBR_ouput[7:0]};
    end
endmodule
