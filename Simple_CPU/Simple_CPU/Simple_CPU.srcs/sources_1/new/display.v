module display(
    //input [0:7] display_place,
    //input [31:0] all_number, //4位BCD
    input [15:0] acc_num,
    input clk,
    output  [7:0] wire_disp_place,
    output  [6:0] wire_disp_number
);
    
    //  ACC->BCD
    integer k;
    reg [3:0] ten_thousands = 4'd0;
    reg [3:0]  thousands = 4'd0;
    reg [3:0]  hundreds = 4'd0;
    reg  [3:0] tens = 4'd0;
    reg  [3:0] ones = 4'd0;
    always @(acc_num)
    begin
        // set all regs to 0;
        ten_thousands = 4'd0;
        thousands = 4'd0;
        hundreds = 4'd0;
        tens = 4'd0;
        ones = 4'd0;
        for (k=15;k>=0;k=k-1)
        begin
            if(ten_thousands >= 5)
                ten_thousands = ten_thousands + 3;
             if(thousands >= 5)
                 thousands = thousands + 3;
            if(hundreds >= 5)
                  hundreds = hundreds + 3;
            if(tens >= 5)
                   tens = tens + 3;
            if(ones >= 5)
                   ones = ones + 3;
                   
              ten_thousands = ten_thousands<<1;
              ten_thousands[0] = thousands[3];
              thousands = thousands<<1;
              thousands[0] = hundreds[3];
              hundreds = hundreds <<1;
              hundreds[0] = tens[3]; 
              tens = tens<<1;
              tens[0] = ones[3];
              ones = ones<<1;
              ones[0] = acc_num[k];                                                                                  
        end
    end
    wire [31:0] all_number;
    assign all_number = {12'h000,ten_thousands,thousands,hundreds,tens,ones};
    
    reg [7:0] disp_place;
    assign wire_disp_place = disp_place;
    reg [6:0] disp_number;
    assign wire_disp_number = disp_number;
    reg [19:0] times;  
    reg [3:0] n;
    (*dont_touch = "true" *) reg [6:0] number[7:0];
    initial times = 0; 
    
    reg [19:0] count = 19'b0;
     reg  clk_1k = 1'b0;
     //1K时钟
     always @ (posedge clk)  
         begin  
             if(count == 100000)  
                 begin
                     count <= 19'b0;
                     clk_1k <= ~clk_1k;
                 end
             else 
                 count <= count + 19'b1;
         end
     
    
   // reg [31:0] all_number=32'h12345678; //4位BCD
    always @ (posedge clk)  
        begin  
            if(times == 800000)  
                times = 20'b0;
            else 
                times = times + 20'b1;
        end
    
    reg [3:0] i;
    reg [3:0] temp;
   always @ (posedge clk)
        begin
            for(i=0;i<8;i=i+1)
            begin
                case(i)
                    0: temp = all_number[3:0];
                    1: temp = all_number[7:4];
                    2: temp = all_number[11:8];
                    3: temp = all_number[15:12];
                    4: temp = all_number[19:16];
                    5: temp = all_number[23:20];
                    6: temp = all_number[27:24];
                    7: temp = all_number[31:28];                    
                endcase
                case(temp)
                    4'b0000: number[i] <= 7'b1000000; //0
                    4'b0001: number[i] <= 7'b1111001  ;
                    4'b0010: number[i] <= 7'b0100100  ;
                    4'b0011: number[i] <= 7'b0110000  ;
                    4'b0100: number[i] <= 7'b0011001  ; //4
                    4'b0101: number[i] <= 7'b0010010  ;
                    4'b0110: number[i] <= 7'b0000010  ;
                    4'b0111: number[i] <= 7'b1111000  ; 
                    4'b1000: number[i] <= 7'b0000000  ;
                    4'b1001: number[i] <= 7'b0010000  ; //9
                    default: number[i] <= 7'b111_1111; //非法码 不亮                                      
                endcase 
            end
        end
        
        
    always@ (posedge clk)  
        begin
             n <= times / 100000;
            case(n)
                3'b000: 
                    begin
                        disp_place<=8'b1111_1110;
                        disp_number <= number[0]; //0
                    end
                3'b001: 
                    begin
                        disp_place<=8'b1111_1101;
                        disp_number <= number[1]; //0
                    end
                3'b010:
                    begin 
                        disp_place<=8'b1111_1011;
                        disp_number <= number[2]; //0
                    end
                3'b011: 
                    begin 
                        disp_place<=8'b1111_0111;
                        disp_number <= number[3]; //0
                    end
                3'b100: 
                    begin 
                        disp_place<=8'b1110_1111;
                        disp_number <= number[4]; //0
                     end
                3'b101: 
                     begin 
                        disp_place<=8'b1101_1111;
                        disp_number <= number[5]; //0
                     end               
                3'b110: 
                     begin 
                        disp_place<=8'b1011_1111;
                        disp_number <= number[6]; //0
                     end                   
                3'b111: 
                      begin 
                        disp_place<=8'b0111_1111;
                        disp_number <= number[7]; //0
                      end   
                 default:
                    begin
                        disp_place<=8'b1111_1111;
                        disp_number<=7'b111_1111;   
                    end                 
            endcase
        end

endmodule