//--------------------------------------------------
// BeeSprite Module : Digilent Basys 3
// BeeInvaders Tutorial 2 : Onboard clock 100MHz
// VGA Resolution 640x480 @ 60Hz : Pixel Clock 25MHz
`timescale 1ns / 1ps
// Setup BeeSprite Module
module BeeSprite(
input wire i_clk,
input wire i_rst,
input wire [9:0] xx,
input wire [9:0] yy,
input wire aactive,
output reg [1:0] BSpriteOn, // 1=on, 0=off
output wire [7:0] dataout
);
// instantiate BeeRom code
reg [16:0] address; // (16:0) or 2^17 or 131072, need 471 x 250 = 117750
BeeRom BeeVRom (.i_addr(address),.i_clk2(i_clk),.o_data(dataout));
// setup character positions and sizes
reg [16:0] BeeX = 80; // Bee X start position
reg [16:0] BeeY = 112; // Bee Y start position
localparam BeeWidth = 471; // Bee width in pixels
localparam BeeHeight = 250; // Bee height in pixels
// check if xx,yy are within the confines of the Bee character
always @ (posedge i_clk)
begin
if (aactive)
begin
if (xx==BeeX-1 && yy==BeeY)
begin
address <= 0;
BSpriteOn <=1;
end
if ((xx>BeeX-1) && (xx<BeeX+BeeWidth) && (yy>BeeY-1) && (yy<BeeY+BeeHeight))
begin
address <= (xx-BeeX) + ((yy-BeeY)*BeeWidth);
BSpriteOn <=1;
end
else
BSpriteOn <=0;
end
end
endmodule