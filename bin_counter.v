`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2019 05:34:52 PM
// Design Name: 
// Module Name: bin_counter
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



module bin_counter #( parameter x=3 , n=3)  (input en, clk, reset, output reg [x-1:0] count, input inc_dec, input adj, input [x-1:0]value);

always @(posedge clk, posedge reset) begin
 if (adj)
    count <= value;
 if (reset == 1)
    count <= 0;
 else if(en == 1)
 if(inc_dec==0)
   if(count < n-1)
   count <= count + 1;
   else
     count <= 0;
 else
    if(count > 0)
     count <= count - 1;
     else
       count <= n - 1;
end
endmodule