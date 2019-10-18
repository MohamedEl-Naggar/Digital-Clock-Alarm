`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2019 09:11:30 PM
// Design Name: 
// Module Name: pos_edge_det
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


module rise_edge_det(input clk, rst, w, output z);
reg [1:0] state, nextState;
parameter [1:0] zero=2'b00, edg=2'b01, one=2'b10; // States Encoding
// Next state generation (combinational logic)
always @ (w or state)
case (state)
zero: if (w==0) nextState = zero;
 else nextState = edg;
edg: if (w==0) nextState = zero;
 else nextState = one;
one: if (w==0) nextState = zero;
 else nextState = one;
default: nextState = zero;
endcase
// State register
// Update state FF's with the triggering edge of the clock
always @ (posedge clk or posedge rst) begin
if(rst) state <= zero;
else state <= nextState;
end
// output generation (combinational logic)
assign z = (state == edg && w ==1);
endmodule


