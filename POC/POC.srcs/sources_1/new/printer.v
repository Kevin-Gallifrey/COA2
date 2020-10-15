`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/12 15:32:47
// Design Name: 
// Module Name: printer
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


module printer(
    input clk,
    output RDY,
    input TR,
    input [7:0] PD,
    output [7:0] print,
    output state_pri
    );
    
    parameter idle=0, busy=1;
    integer i=0;
    reg state=idle;
    reg rRDY=1;
    reg preTR=0;
    reg [7:0]rprint=0;
    reg [2:0]count=0;
    
    assign RDY=rRDY;
    assign print=rprint;
    assign state_pri=state;
    
    always@(posedge clk)
    begin
        case(state)
            idle:begin
                if(TR) begin                 
                    rRDY <= 0;
                    if(rRDY==0) state <= busy;
                    else state <= idle;
                end
                else state <= idle;
            end
            busy:begin                
                if(count[2]==1) begin       
                    rRDY <= 1;
                    rprint <= 0;
                    count <= 0;
                    state <= idle;
                end
                else begin
                    rprint <= PD;                    
                    count <= count + 1;
                    state <= busy;
                end
            end
        endcase
    end
    
endmodule
