`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2019 05:37:44 PM
// Design Name: 
// Module Name: dec2x4
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

module dec2x4(in[1:0], en, y[3:0]);
input [1:0] in;
input en;
output reg [3:0] y;
always @(in or en) begin
y = 4'b0000;
if (en == 1'b1)
case ( in )
 2'b00: y = 4'b0001;
 2'b01: y = 4'b0010;
 2'b10: y = 4'b0100;
 2'b11: y = 4'b1000;
endcase
end
endmodule
