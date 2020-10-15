`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/23 15:07:56
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
    input rst,
    output [2:0] flag,
    output [6:0] seg_data,
    output [7:0] seg_cs
    );
    
    // define all the wires needed 
    wire [15:0] ACC_output;
    wire [15:0] BR_output;
    wire [15:0] ALU_output;
    wire [15:0] MR_output;
    wire [15:0] DR_output;
    wire [3:0] Op;
    wire [18:0] C;
    wire [7:0] IR_output;
    wire [15:0] MBR_output;
    wire [7:0] PC_output;
    wire [7:0] MAR_output;
    wire [15:0] RAM_output;
    //wire [2:0] flag;
    
    ALU U0(
        .ACC_input(ACC_output),     // Input from ACC
        .BR_input(BR_output),        // Input from BR
        .Op(Op),                // Define Operation
        .C14(C[14]),                        // Gate BR->ALU
        .C15(C[15]),                       //  Gate ACC->ALU
        .ACC_output(ALU_output),    // Output to ACC
        .MR_output(MR_output),
        .DR_output(DR_output),
        .flag(flag)
        );
        
    CU U1(
        .clk(clk),
        .IR(IR_output),
        .rst(rst),
        .C(C),
        .OP(Op),
        .flag(flag)
    );
    
    ACC U2(
        .clk(clk),
        .C16(C[16]),
        .C8(C[8]),
         .ALU_output(ALU_output),
        .ACC_output(ACC_output)
        );    

    BR U3(
        .clk(clk),
        .C7(C[7]),
        .C9(C[9]),
        .MBR_ouput(MBR_output),
        . BR_output(BR_output)
        );    
        
      IR U4(
            .clk(clk),
            .C4(C[4]),   // MBR->IR
            .MBR_ouput(MBR_output[15:8]),
            .IR_output(IR_output)
            );        
            
        MAR U5(
                .clk(clk),
                .C5(C[5]),    // MBR->MAR
                .C10(C[10]),   // PC->MAR
                .MBR_addr(MBR_output[7:0]),
                .PC_addr(PC_output),
                .MAR_output(MAR_output)
                );
                
            MBR U6(
                   .clk(clk),
                   .C11(C[11]),  //  ACC->MBR
                   .C3(C[3]),  //  RAM->MBR
                   .C17(C[17]),
                   .C18(C[18]),
                   .ACC_output(ACC_output),
                   .RAM_output(RAM_output),
                   .MBR_output(MBR_output),
                   .MR_output(MR_output),
                   .DR_output(DR_output)
                    );
 
                PC U7(
                        .clk(clk),
                        .C6(C[6]),   // MBR->PC
                        .C13(C[13]),
                        .MBR_ouput(MBR_output[7:0]),
                        .PC_output(PC_output)
                        );   
                                  
                RAM U8(
                            .clk(clk),                            
                            .C12(C[12]),   // MBR->RAM
                            .rst(rst),
                           // .C13(C[13]),   // MAR> RAM
                            .MAR_input(MAR_output),
                            .MBR_input(MBR_output),
                            .RAM_output(RAM_output)
                            );          
                            
                 display U9(
                                .clk(clk),
                                .acc_num(ACC_output),
                                .wire_disp_number(seg_data),
                                .wire_disp_place(seg_cs)
                 );                                      
endmodule
