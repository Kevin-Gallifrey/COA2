`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 20:02:36
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input C6,   // MBR->PC
    input C13,
    input [7:0] MBR_ouput,
    output reg [7:0] PC_output = 8'b0000_0000
    );
    
    wire [7:0] next_PC = PC_output + 8'b01;
    always @(posedge clk)
    begin
        if(C13)
            PC_output <=  MBR_ouput;
        if(C6)
            PC_output <= next_PC;
    end
    
    
endmodule