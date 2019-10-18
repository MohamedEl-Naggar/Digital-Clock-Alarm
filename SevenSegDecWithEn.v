`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2019 05:36:39 PM
// Design Name: 
// Module Name: SevenSegDecWithEn
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


module SevenSegDecWithEn(input en, clk, input reset, input [3:0] num,input [1:0] s,output reg [6:0] segments,output reg dec_point, input state, output reg [3:0] Anode_Activate);
wire temp;
wire clk_out2;
clockDivider #(25000000)clk_div28 (clk, reset,clk_out2);
bin_counter #(1,2) c7 (1, clk_out2, reset , temp);

always @ (*) begin
if (en == 1)
case(s)
2'b00: begin Anode_Activate =4'b1110; dec_point = 1; end
2'b01: begin Anode_Activate = 4'b1101; dec_point = 1; end
2'b10: begin Anode_Activate =4'b1011; dec_point = (state)? 0: temp; end
2'b11: begin Anode_Activate =4'b0111; dec_point = 1; end
endcase 
else begin
Anode_Activate = 4'b1111; dec_point = 1; end
end

always @(*)  begin
case(num)
0:segments=7'b0000001;
1:segments=7'b1001111;
2:segments=7'b0010010;
3:segments=7'b0000110;
4:segments=7'b1001100;
5:segments=7'b0100100;
6:segments=7'b0100000;
7:segments=7'b0001111;
8:segments=7'b0000000;
9:segments=7'b0000100;
10:segments=7'b0001000;
11:segments=7'b1100000;
12:segments=7'b0110001;
13:segments=7'b1000010;
14:segments=7'b0110000;
15:segments=7'b0111000;
endcase
end

endmodule