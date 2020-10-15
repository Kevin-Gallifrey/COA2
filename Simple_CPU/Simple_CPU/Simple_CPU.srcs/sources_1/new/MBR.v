`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 20:02:36
// Design Name: 
// Module Name: MBR
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


module MBR(
    input clk,
    input C11,  //  ACC->MBR
    input C3,   //  RAM->MBR
    input C17, //  MR->MBR
    input C18, //DR->MBR
    input [15:0] ACC_output,
    input [15:0] MR_output,
    input [15:0] DR_output,
    input [15:0] RAM_output,
    output reg [15:0] MBR_output
    );
    
    always @(posedge clk)
    begin
        if(C11)
            MBR_output <= ACC_output;
        else if(C17)
            MBR_output <= MR_output;
        else if(C18)
            MBR_output <= DR_output;
        else if(C3)
            MBR_output <= RAM_output;
    end
    
endmodule
