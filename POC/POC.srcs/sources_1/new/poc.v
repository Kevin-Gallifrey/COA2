`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/12 15:32:47
// Design Name: 
// Module Name: poc
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


module poc(
    input clk,
    input ADDR,
    output [7:0] Dout,
    input [7:0] Din,
    input RW,   //1为读，0为写
    output IRQ,
    input EN,    //中断使能 EN=1进入中断方式
    input RDY,
    output TR,
    output [7:0]PD,
    output [1:0]state_poc
    );
    
    reg [7:0] BR=0;
    reg [7:0] SR=8'b1000_0000;
    reg [7:0] Rout=0;
    reg irq=0;
    
    assign Dout = Rout;
    assign IRQ =irq;
    
    reg [1:0]state=0;
    reg regTR=0;
    reg [7:0]rPD=0;
    
    assign TR = regTR;
    assign PD = rPD;
    assign state_poc = state;
    
    always@(posedge clk)
    begin
        if(EN) begin
            SR[0] = 1;
        end
        else begin
            SR[0] = 0;
        end
        case(state)
            0:begin             //state=0, 与processor通信
                Rout <= 0;
                if(SR[0]==1 && SR[7]==1) irq=1;
                else irq=0;
                if(SR[7]==0) state <= 1;
                else begin
                    case(ADDR)
                        1'b1:begin  //选中SR
                                if(RW) Rout <= SR;
                                else SR <= Din;
                             end
                        1'b0:begin  //选中BR
                                if(RW) Rout <= BR;
                                else BR <= Din;
                             end
                    endcase
                end
            end
            1:begin             //state=1, 与打印机握手
                if(RDY) begin
                    regTR <= 1;
                    state <= 2;
                end
                else state <= 1;
            end
            2:begin             //state=2, 发送数据给打印机
                if(RDY==0) begin
                    regTR <= 0;
                    rPD <= BR;
                    SR[7] <= 1;
                    BR <= 0;
                    state <= 0;
                end
                else state <= 2;
            end
            default:begin
                state <= 0;
            end
        endcase
    end
    

    
endmodule
