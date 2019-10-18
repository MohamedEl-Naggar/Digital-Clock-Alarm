`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2019 05:35:16 PM
// Design Name: 
// Module Name: modulo_10
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


module modulo_10(input clk, reset, output [2:0] secTens, output [3:0] secUnits, output [2:0] minTens, output[3:0] minUnits, output [1:0]hourTens, output [3:0]hourUnits,
input [2:0] mintens_adj, input [3:0] minunits_adj, input [3:0] hourunits_adj, input [1:0] hourtens_adj, input adj);
wire clk_out;
wire reset1;
clockDivider #(250000)clk_div (clk, reset,clk_out ); //50000000
bin_counter #(4, 10)c1 (1, clk_out, reset, secUnits, 0, 0, 0);
bin_counter #(3, 6)c3 ((secUnits==9), clk_out, reset, secTens, 0, 0, 0);
bin_counter #(4, 10)c2 ((secTens==5 && secUnits==9)  , clk_out, reset, minUnits, 0, adj, minunits_adj);
bin_counter #(3, 6)c4 ((minUnits==9&&secTens==5&&secUnits==9 )  , clk_out, reset, minTens, 0, adj, mintens_adj);
bin_counter #(4, 10)c5 ((minTens==5 && minUnits==9 && secTens==5&&secUnits==9)  , clk_out, reset1 | reset, hourUnits, 0, adj, hourunits_adj);
bin_counter #(2, 3)c6 ((minUnits==9&&minTens==5&&hourUnits==9 && secTens==5&&secUnits==9)  , clk_out, reset1 | reset, hourTens, 0, adj, hourtens_adj);

assign reset1 = (hourUnits==4 && hourTens==2)? 1:0;
endmodule
