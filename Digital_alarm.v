`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2019 05:32:22 PM
// Design Name: 
// Module Name: Digital_alarm
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

module Digital_alarm(input clk, rst, btnc, alarm_en, input [3:0] btn, output [0:6] segments,output dec_point, output [3:0] anode_active, output reg state, output [3:0] led, output alarm_led);
wire clk_out;
wire [1:0] bin_counter_wire, bin_counter_wire_adj,bin_counter_wire_alarm, bin_counter_wire_ca;
wire [3:0] mux_out, mux_out_adj, mux_out_alarm, mux_out_ca;
wire [2:0] sectens;
wire [3:0] secunits;
wire [2:0] mintens;
wire [3:0] minunits;
wire [1:0] hourtens;
wire [3:0] hourunits;
wire [2:0] mintens_adj;
wire [3:0] minunits_adj;
wire [1:0] hourtens_adj;
wire [3:0] hourunits_adj;
wire [2:0] mintens_alarm;
wire [3:0] minunits_alarm;
wire [1:0] hourtens_alarm;
wire [3:0] hourunits_alarm;
reg adj;
wire temp;
wire [3:0] obtn;
wire obtnc, btncq4;
wire [1:0]counter;
initial state = 0;
reg alarm;
wire [7:0] counter200;
wire clk_out2, clk_out3;
clockDivider #(12500000) clk_div25454 (clk, rst,clk_out2);
bin_counter #(1,2) c7 (1, clk_out2, rst , temp);

clockDivider #(500000) clk_div3 (clk, rst,clk_out3);
bin_counter #(8,201) c8 (btncq4, clk_out3, obtnc, counter200);

assign alarm_led = (alarm)? temp : 0;

always @(posedge clk)
begin
if (!alarm_en)
    alarm = 0;
else if ((mintens_alarm==mintens) && (minunits_alarm==minunits) && (hourtens_alarm==hourtens) && (hourunits_alarm==hourunits))
    alarm = 1;
else if (obtn != 0 || obtnc)
    alarm = 0;
end

always @(posedge clk or posedge rst)
begin
    if (rst == 1)
        state = 0;
    else if (counter200 == 200 && state == 0)
        state = 1;
    else if (obtnc && state)
        state = 0;
end

always @(posedge clk_out3)
begin
end
Pushbutton fdk(btnc, clk, rst, obtnc, btncq4);
Pushbutton fdk0(btn[0], clk, rst, obtn[0]);
Pushbutton fdk1(btn[1], clk, rst, obtn[1]);
Pushbutton fdk2(btn[2], clk, rst, obtn[2]);
Pushbutton fdk3(btn[3], clk, rst, obtn[3]);

clockDivider #(250000)clk_div2 (clk, rst,clk_out ); 

bin_counter #(2, 4) c1(1, clk_out, rst, bin_counter_wire, 1, 0, 0);
bin_counter #(2, 4) c2(1, clk_out, rst, bin_counter_wire_adj, 1, 0, 0);
bin_counter #(2, 4) c3(1, clk_out, rst, bin_counter_wire_alarm, 1, 0, 0);

adjust ad (state, clk, obtn, mintens_alarm, minunits_alarm, hourunits_alarm, hourtens_alarm, mintens_adj, minunits_adj, hourunits_adj, hourtens_adj, led, counter);

modulo_10 s(clk, rst, sectens, secunits, mintens,  minunits, hourtens, hourunits, mintens_adj, minunits_adj, hourunits_adj, hourtens_adj, adj);
mux_4to1_assign f(minunits, mintens ,hourunits ,hourtens,bin_counter_wire, mux_out);
assign mux_out_ca = (state == 0)? mux_out : (counter<2)?mux_out_adj : mux_out_alarm;
assign bin_counter_wire_ca = (state == 0)? bin_counter_wire : (counter<2)? bin_counter_wire_adj : bin_counter_wire_alarm;
mux_4to1_assign f1 (minunits_adj, mintens_adj ,hourunits_adj ,hourtens_adj, bin_counter_wire_adj, mux_out_adj);
mux_4to1_assign f2 (minunits_alarm, mintens_alarm ,hourunits_alarm ,hourtens_alarm, bin_counter_wire_alarm, mux_out_alarm);
SevenSegDecWithEn sa(1 ,clk, rst, mux_out_ca, bin_counter_wire_ca, segments, dec_point, state, anode_active);

always @ (posedge clk)
begin
if ((mintens_adj != 0 || minunits_adj != 0 || hourunits_adj != 0 || hourtens_adj != 0) && state)
    adj = 1;
else
    adj = 0;
end
endmodule