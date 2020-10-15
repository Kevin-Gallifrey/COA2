`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/02 15:26:32
// Design Name: 
// Module Name: sim_poc
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


module sim_poc();

    reg clk;        //输入用reg，输出用wire
    reg EN;
    reg [7:0] data;
    wire [7:0] print;
    
    wire ADDR, RW, IRQ, RDY, TR;
    wire [7:0] Dout;
    wire [7:0] Din;
    wire [7:0] PD;
    
    wire [1:0]state_pro;
    wire [1:0]state_poc;
    wire state_pri;
    
    poc u1(
        clk,
        ADDR,
        Dout,
        Din,
        RW,   //1为读，0为写
        IRQ,
        EN,    //中断使能 EN=1进入中断方式
        RDY,
        TR,
        PD,
        state_poc
        );
    
    printer u2(
        clk,
        RDY,
        TR,
        PD,
        print,
        state_pri
        );
    
    processor u3(
        ADDR,
        Dout,
        Din,
        RW,
        IRQ,
        clk,
        data,      //输入数据，用于仿真测试
        state_pro
        );
    
    initial
    begin
    clk=0;
    EN=0;
    data=8'b0110_0011;
    #15 data=8'b1010_0101;
    #20 data=8'b1001_1100;
    #15 EN=1;
    #20 data=8'b0101_1010;
    #40 $stop;
    end
    
    always #1 clk=~clk;
        
endmodule
