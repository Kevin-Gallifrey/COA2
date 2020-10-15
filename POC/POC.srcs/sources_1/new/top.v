`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/12 14:59:46
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input EN,
    output print,
    input [7:0] data    
    );
    
    wire ADDR, RW, IRQ, RDY, TR;
    wire [7:0] Dout;
    wire [7:0] Din;
    wire [7:0] PD;
    
    poc u1(
        clk,
        ADDR,
        Dout,
        Din,
        RW,   //1Ϊ����0Ϊд
        IRQ,
        EN,    //�ж�ʹ�� EN=1�����жϷ�ʽ
        RDY,
        TR,
        PD
        );
    
    printer u2(
        clk,
        RDY,
        TR,
        PD,
        print
        );
    
    processor u3(
        ADDR,
        Dout,
        Din,
        RW,
        IRQ,
        clk,
        data      //�������ݣ����ڷ������
        );
        
endmodule
