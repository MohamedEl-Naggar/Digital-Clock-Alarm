`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2019 21:41:14
// Design Name: 
// Module Name: adjust
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

module adjust(input en, input clk, input [3:0] btn, output [2:0] mintens_alarm, output [3:0] minunits_alarm, output [3:0] hourunits_alarm, output [1:0] hourtens_alarm,
output [2:0] mintens, output [3:0] minunits, output [3:0] hourunits, output [1:0] hourtens, output reg [3:0] led, output reg [1:0] counter);
initial counter = 0;
reg adj;
initial adj = 0;
wire [1:0] adj1_val;
wire adj1, adj1_alarm;

bin_counter #(4, 10)c1 ((btn[1] || btn[3]) && (counter == 0) && en, clk, 0, minunits, btn[1], adj, 0);
bin_counter #(3, 6) c2 (((minunits == 9 && btn[3]) || (minunits == 0 && btn[1])) && (counter == 0) && en, clk, 0, mintens, (minunits == 0 && btn[1]), adj, 0);

bin_counter #(4, 10)c3 ((btn[1] || btn[3]) && (counter == 1) && en, clk, (hourunits == 4 && hourtens == 2), hourunits, btn[1], adj | adj1, adj1_val);
bin_counter #(2, 3) c4 (((hourunits == 9 && btn[3]) || (hourunits == 0 && btn[1])) && (counter == 1) && en, clk, (hourunits == 4 && hourtens == 2), hourtens, (hourunits == 0 && btn[1]), adj, 0);

bin_counter #(4, 10)c5 ((btn[1] || btn[3]) && (counter == 2) && en, clk, 0, minunits_alarm, btn[1], 0, 0);
bin_counter #(3, 6) c6 (((minunits_alarm == 9 && btn[3]) || (minunits_alarm == 0 && btn[1])) && (counter == 2) && en, clk, 0, mintens_alarm, (minunits_alarm == 0 && btn[1]), 0, 0);

bin_counter #(4, 10)c7 ((btn[1] || btn[3]) && (counter == 3) && en, clk, (hourunits_alarm == 4 && hourtens_alarm == 2), hourunits_alarm, btn[1], adj1_alarm, 3);
bin_counter #(2, 3) c8 (((hourunits_alarm == 9 && btn[3]) || (hourunits_alarm == 0 && btn[1])) && (counter == 3) && en, clk, (hourunits_alarm == 4 && hourtens_alarm == 2), hourtens_alarm, (hourunits_alarm == 0 && btn[1]), 0, 0);

assign adj1_val = (adj1)? 3 : 0;
assign adj1 = (hourunits == 9 && hourtens ==2)? 1 : 0;
assign adj1_alarm = (hourunits_alarm == 9 && hourtens_alarm ==2)? 1 : 0;


always @ (posedge clk)
begin
    if (en)
    begin
        adj = 0;
        case (btn)
            4'b0001: counter = counter + 1;
            4'b0100: counter = counter - 1;
            default:;
        endcase
        case (counter)
        0:led = 4'b1000;
        1:led = 4'b0100;
        2:led = 4'b0010;
        3:led = 4'b0001;
        endcase
    end
    else
    begin
        led = 0;
        adj = 1;
    end
end
endmodule