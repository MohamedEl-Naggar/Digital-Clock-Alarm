`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2019 08:48:23 PM
// Design Name: 
// Module Name: button
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


module Pushbutton(input in, clk, rst, output out, output reg q4);
wire clk_out, o;
reg q1, q2, q3;
clockDivider #(400000) c(clk, rst, clk_out);
always @ (posedge clk_out) begin
q1<=in;
q2<=q1;
q3<=q2;
end
assign o = q1&q2&q3;
always @(posedge clk) begin
q4<=o;
end
rise_edge_det x(clk, rst, q4, out);
endmodule