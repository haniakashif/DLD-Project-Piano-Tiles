`timescale 1ns / 1ps

module top_mod(
    input clk,
    input rst,
    input button_1,
    input button_2,
    input button_3,
    input button_4,
    input start_button,
    output h_sync,
    output v_sync,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue,
    output [0:6] seg,
    output [3:0] an  
     
    );
    wire clk_d;
    wire [4:0] rand;
    wire [2:0] num;
    wire [3:0] state;
    wire [9:0] h_count;
    wire trig_v;
    wire [9:0] v_count; 
    wire video_on;
    wire [9:0] x_loc;
    wire [9:0] y_loc;
    wire state_change;
    wire active;
    wire BeeSpriteOn;
    wire [7:0] dout;
    wire GSpriteOn;
    wire [7:0] gout;
    wire [9:0] score;
    wire [3:0] one;
    wire [3:0] ten;
    wire [3:0] hun;
    wire [3:0] thou;
    
    clock c(clk,clk_d);
    h_counter h1 (clk_d, h_count,trig_v); //horizontal timing generator
    count_v v1 (clk_d, trig_v, v_count); // vertical timing geenrator
    vga_sync s1 (h_count, v_count, h_sync, v_sync, active, x_loc, y_loc); // displaying the screen and refreshing h_count and v_count to sync the display
    random r1(clk_d,rst,rand);
    rand_div rd(rand,num);
    rand_to_state rts (clk_d,num,state,state_change,check);
    ScreenSprite BeeDisplay (clk_d,rst,x_loc,y_loc,active,BeeSpriteOn,GSpriteOn,dout,gout);
//    gameoverSprite GDisplay (.i_clk(clk_d),.i_rst(rst),.xx(x_loc),.yy(y_loc),.aactive(active),.GSpriteOn(GSpriteOn),.dataout(gout));
    pix_gen p1(clk_d, x_loc, y_loc,state,active,BeeSpriteOn,dout,GspriteOn,gout,button_1,button_2,button_3,button_4,start_button,state_change, red, green, blue,score); 
    digits dig(score,one,ten,hun,thou);
    seg7_control seg7(clk_d,rst,one,ten,hun,thou,seg,an);
endmodule
