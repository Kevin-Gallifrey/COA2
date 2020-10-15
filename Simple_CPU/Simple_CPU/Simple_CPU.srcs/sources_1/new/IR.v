`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 20:09:24
// Design Name: 
// Module Name: IR
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


module IR(
    input clk,
    input C4,   // MBR->IR
    input [7:0] MBR_ouput,
    output reg [7:0] IR_output
    );
    
    always @(posedge clk)
    begin
        if(C4)
            IR_output <=  MBR_ouput;
    end
    
    
endmodule
