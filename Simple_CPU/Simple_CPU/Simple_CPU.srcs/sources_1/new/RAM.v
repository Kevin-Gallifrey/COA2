`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 18:39:07
// Design Name: 
// Module Name: RAM
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


module RAM(
    input clk,
    input rst,
    input C12,  // MBR->RAM
   // input C13,  // MAR> RAM
    input [7:0] MAR_input,
    input [15:0] MBR_input,
    output [15:0] RAM_output
    );
    
    reg signed  [15:0] ram[255:0];
    
   always @(posedge clk) 
   begin
        if(~rst)
            begin
            //testing  ((1+3+5+...+69)*(-9)*137)
            ram[8'h00] = 16'h02a0;  // Load A0
            ram[8'h01] = 16'h01a4;  //STORE A4
            ram[8'h02] = 16'h02a2;  //LOAD A2
            ram[8'h03] = 16'h01A3;  //STORE A3
            ram[8'h04] = 16'h02A4;  //LOOP:LOAD A4
            ram[8'h05] = 16'h03A3;  //ADD A3
            ram[8'h06] = 16'h01A4;  //STORE A4
            ram[8'h07] = 16'h02A3;  //LOAD A3
            ram[8'h08] = 16'h04A1;  //SUB A1
            ram[8'h09] = 16'h01A3;  //STORE A3
            ram[8'h0A] = 16'h0604;  //JMPGEZ LOOP   06:>0 JMP; 05:<0 JMP
            ram[8'h0B] = 16'h02A4;  //LOAD A4
            ram[8'h0C] = 16'h08A5;  //MPY A5
            ram[8'h0D] = 16'h01A4;  //STORE A4
            ram[8'h0E] = 16'h08A6;  //MPY A6
            ram[8'h0F] = 16'h01A4;  //STORE A4
            ram[8'h10] = 16'h0E01;  //SHR 1
            ram[8'h11] = 16'h01A4;  //STORE A4
            ram[8'h13] = 16'h07f3;  //HALT
            ram[8'hA0] = 16'h0000;
            ram[8'hA1] = 16'h0002;
            ram[8'hA2] = 16'h0045;
            ram[8'hA5] = -16'h0009;
            ram[8'hA6] = 16'h0089;
            
            
            // test all the instructions
            /*
            ram[8'h00] = 16'h02f1;  // LOAD [X]
            ram[8'h01] = 16'h03f2; // ADD [x]
            ram[8'h02] = 16'h04f3; //SUB [x]
            ram[8'h03] = 16'h01f0; // STORE [x]
            ram[8'h04] = 16'h08f4; // MPY [x]
            ram[8'h05] = 16'h09f5; // DIV [x]
            ram[8'h06] = 16'h0af6; // AND
            ram[8'h07] = 16'h0bf7; // OR
            ram[8'h08] = 16'h0cf8; // XOR
            ram[8'h09] = 16'h01f0; // STORE [x]
            ram[8'h0a] = 16'h0df0; // NOT [x]
            ram[8'h0b] = 16'h0e00; // SHIFT R
            ram[8'h0c] = 16'h0f00; // SHIFT L
            ram[8'h0d] = 16'h100f; // LOAD X
            ram[8'h0e] = 16'h1102; // ADD X
            ram[8'h0f] = 16'h1205; // SUB X
            ram[8'h10] = 16'h13ff; // MPY X
            ram[8'h11] = 16'h1403; // DIV X
            ram[8'h12] = 16'h15ff; // AND X
            ram[8'h13] = 16'h160f; // OR X
            ram[8'h14] = 16'h170f; //  XOR X
            ram[8'h15] = 16'h18bb; //  NOT X
            ram[8'h16] = 16'h07bb; //  HALT
            ram[8'hf0] = 16'd0;
            ram[8'hf1] = 16'd100;
            ram[8'hf2] = 16'd50;
            ram[8'hf3] = 16'd200;
            ram[8'hf4] = -16'd2;
            ram[8'hf5] = 16'd4;
            ram[8'hf6] = 16'h000f;
            ram[8'hf7] = 16'h00f0;
            ram[8'hf8] = 16'h00ff;
            ram[8'hf9] = 16'h0000;
            */
            /*
            //  [(((1+2+3+бнбн+20)/5)<<2)*100 ]and 16'hff00 
                       ram[8'h00] = 16'h02a0;  // Load  A0
                       ram[8'h01] = 16'h01a4;  //STORE A4
                       ram[8'h02] = 16'h02a2;  //LOAD A2
                       ram[8'h03] = 16'h01A3;  //STORE A3
                       ram[8'h04] = 16'h02A4;  //LOOP:LOAD A4
                       ram[8'h05] = 16'h03A3;  //ADD A3
                       ram[8'h06] = 16'h01A4;  //STORE A4
                       ram[8'h07] = 16'h02A3;  //LOAD A3
                       ram[8'h08] = 16'h04A1;  //SUB A1
                       ram[8'h09] = 16'h01A3;  //STORE A3
                       ram[8'h0A] = 16'h0604;  //JMPGEZ LOOP
                       ram[8'h0B] = 16'h02A4;  //  LOAD  A4
                       ram[8'h0C] = 16'h1406;  //  DIV 5
                       ram[8'h0D] = 16'h0F00;  //  SHIFTL 
                       ram[8'h0E] = 16'h0F00;  //  SHIFTL 
                       ram[8'h0F] = 16'h1364;  //  MPY 100
                       ram[8'h10] = 16'h0AA5;  //  AND [A5]
                       ram[8'h11] = 16'h01A4;  //  STORE A4
                       ram[8'h12] = 16'h0700;  //  HALT
                       ram[8'hA0] = 16'h0000;
                       ram[8'hA1] = 16'h0001;
                       ram[8'hA2] = 16'h0014;
                        ram[8'hA5] = 16'h00FF;
                        */
            // sum 1~100
            /*
            ram[8'h00] = 16'h02a0;  // Load  A0
            ram[8'h01] = 16'h01a4;  //STORE A4
            ram[8'h02] = 16'h02a2;  //LOAD A2
            ram[8'h03] = 16'h01A3;  //STORE A3
            ram[8'h04] = 16'h02A4;  //LOOP:LOAD A4
            ram[8'h05] = 16'h03A3;  //ADD A3
            ram[8'h06] = 16'h01A4;  //STORE A4
            ram[8'h07] = 16'h02A3;  //LOAD A3
            ram[8'h08] = 16'h04A1;  //SUB A1
            ram[8'h09] = 16'h01A3;  //STORE A3
            ram[8'h0A] = 16'h0504;  //JMPGEZ LOOP
            ram[8'h0B] = 16'h07f3;  //  HALT
            ram[8'hA0] = 16'h0000;
            ram[8'hA1] = -16'h0001;
            ram[8'hA2] = -16'h0064;
           */
            end
            
        else if(C12)
            ram[MAR_input] <= MBR_input;     
   end
   
    assign RAM_output = ram[MAR_input];
    
endmodule
