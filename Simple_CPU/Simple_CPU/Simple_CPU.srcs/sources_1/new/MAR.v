`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 19:55:43
// Design Name: 
// Module Name: MAR
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


module MAR(
    input clk,
    input C5,   // MBR->MAR
    input C10,  // PC->MAR
    input [7:0] MBR_addr,
    input [7:0] PC_addr,
    output reg [7:0] MAR_output
    );
   
    always @(posedge clk)
    begin
        if(C5)
            MAR_output <= MBR_addr;
        else if(C10)
            MAR_output <= PC_addr;
    end
    
    
endmodule
