`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/12 15:18:58
// Design Name: 
// Module Name: processor
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


module processor(
    output ADDR,
    input [7:0] Dout,
    output [7:0] Din,
    output RW,
    input IRQ,
    input clk,
    input [7:0] data,      //输入数据，用于仿真测试
    output [1:0]state_pro
    );
    
    parameter query=0, writeBR=1, setSR=2;
    reg [1:0]state=query;
    reg addrReg=1;
    reg rw=1;
    reg [7:0] Rin=0;
    
    assign ADDR=addrReg;
    assign Din=Rin;
    assign RW=rw;
    assign state_pro=state;
    
    always@(posedge clk)
    begin
        case(state)
            query:begin
                Rin <= 0;
                if(IRQ) state <= writeBR;
                else begin
                    addrReg <= 1;   //查询SR
                    rw <= 1;
                    if(Dout[7]==1) state <= writeBR;
                    else state <= query;
                end
            end
            
            writeBR:begin
                addrReg <= 0;   //写入BR
                rw <= 0;
                Rin <= data;
                state <= setSR;   
            end
            
            setSR:begin
                addrReg <= 1;   //写入SR
                rw <= 0;
                Rin <= 0;
                state <= query;
            end
            
            default:begin
                state <= query;
            end
            
        endcase
    end
    
endmodule
