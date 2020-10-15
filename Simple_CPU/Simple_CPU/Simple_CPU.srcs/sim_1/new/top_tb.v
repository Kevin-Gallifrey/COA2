`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/27 19:50:10
// Design Name: 
// Module Name: top_tb
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


module top_tb();
    reg clk;
    reg rst;
    
    initial begin
        clk = 1'b1;
        forever 
        #5 clk = ~clk;
        #50000  $finish;
    end  
    
    initial begin
    rst = 0;
    #3 rst = 1; 
    
    end
    
    top U(
         .clk(clk),
         .rst(rst)
         
        //output [15:0] Flag,
        //output [7:0] seg_data,
        //output [7:0] seg_cs
        );
endmodule
