////////////////////////////////////////////////////////////////////


module Eight_pt_fft (xin1,xin2,xin3,xin4,xin5,xin6,xin7,xin8,
                       yin1,yin2,yin3,yin4,yin5,yin6,yin7,yin8,
                       xout,yout,clock,en);

	input signed [15:0] xin1,xin2,xin3,xin4,xin5,xin6,xin7,xin8;
	input signed [15:0] yin1,yin2,yin3,yin4,yin5,yin6,yin7,yin8;
	
    output signed [127:0] xout;
    output signed [127:0] yout;
    
    input clock,en;
    
 
    
    wire signed[31:0] angle_lut [0:3];
    wire  signed[15:0] xtemp_in[0:7],ytemp_in[0:7];
    wire signed[15:0] xtemp_1[0:7],ytemp_1[0:7],xtemp_2[0:7],ytemp_2[0:7],xtemp_3[0:7],ytemp_3[0:7], xtemp_11[0:7],ytemp_11[0:7], xtemp_21[0:7],ytemp_21[0:7];
    
   
     
    assign angle_lut[0] = 32'b00_0000000000000000000000000000000;  //  W 0_8
    assign angle_lut[1] = 32'b00_10_0000000000000000000000000000;  //  W 1_8
    assign angle_lut[2] = 32'b01_00_0000000000000000000000000000;  //  W 2_8
    assign angle_lut[3] = 32'b01_10_0000000000000000000000000000;  //  W 3_8
    
 
    assign  {xtemp_in[0],xtemp_in[1],xtemp_in[2],xtemp_in[3],xtemp_in[4],xtemp_in[5],xtemp_in[6],xtemp_in[7]} = (en == 1) ?  {xin1,xin2,xin3,xin4,xin5,xin6,xin7,xin8} : 0;
    assign  {ytemp_in[0],ytemp_in[1],ytemp_in[2],ytemp_in[3],ytemp_in[4],ytemp_in[5],ytemp_in[6],ytemp_in[7]} = (en == 1) ?  {yin1,yin2,yin3,yin4,yin5,yin6,yin7,yin8} : 0;
  


butterfly b4 ( .x1(xin1), .y1(yin1), .x2(xin2), .y2(yin2), .xout1(xtemp_1[0]), .yout1(ytemp_1[0]), .xout2(xtemp_1[1]), .yout2(ytemp_1[1]));
butterfly b5 ( .x1(xin3), .y1(yin3), .x2(xin4), .y2(yin4), .xout1(xtemp_1[2]), .yout1(ytemp_1[2]), .xout2(xtemp_1[3]), .yout2(ytemp_1[3]));
butterfly b6 ( .x1(xin5), .y1(yin5), .x2(xin6), .y2(yin6), .xout1(xtemp_1[4]), .yout1(ytemp_1[4]), .xout2(xtemp_1[5]), .yout2(ytemp_1[5]));
butterfly b7 ( .x1(xin7), .y1(yin7), .x2(xin8), .y2(yin8), .xout1(xtemp_1[6]), .yout1(ytemp_1[6]), .xout2(xtemp_1[7]), .yout2(ytemp_1[7]));

cordic c7(clock,angle_lut[2],xtemp_1[3],ytemp_1[3],xtemp_11[3],ytemp_11[3]);
cordic c8(clock,angle_lut[2],xtemp_1[7],ytemp_1[7],xtemp_11[7],ytemp_11[7]);

butterfly b8  ( .x1(xtemp_1[0]), .y1(ytemp_1[0]), .x2(xtemp_1[2]), .y2(ytemp_1[2]), .xout1(xtemp_2[0]), .yout1(ytemp_2[0]), .xout2(xtemp_2[2]), .yout2(ytemp_2[2]));
butterfly b9  ( .x1(xtemp_1[1]), .y1(ytemp_1[1]), .x2(xtemp_11[3]), .y2(ytemp_11[3]), .xout1(xtemp_2[1]), .yout1(ytemp_2[1]), .xout2(xtemp_2[3]), .yout2(ytemp_2[3]));
butterfly b10 ( .x1(xtemp_1[4]), .y1(ytemp_1[4]), .x2(xtemp_1[6]), .y2(ytemp_1[6]), .xout1(xtemp_2[4]), .yout1(ytemp_2[4]), .xout2(xtemp_2[6]), .yout2(ytemp_2[6]));
butterfly b11 ( .x1(xtemp_1[5]), .y1(ytemp_1[5]), .x2(xtemp_11[7]), .y2(ytemp_11[7]), .xout1(xtemp_2[5]), .yout1(ytemp_2[5]), .xout2(xtemp_2[7]), .yout2(ytemp_2[7]));

cordic c9 (clock,angle_lut[1],xtemp_2[5],ytemp_2[5],xtemp_21[5],ytemp_21[5]);
cordic c10(clock,angle_lut[2],xtemp_2[6],ytemp_2[6],xtemp_21[6],ytemp_21[6]);
cordic c11(clock,angle_lut[3],xtemp_2[7],ytemp_2[7],xtemp_21[7],ytemp_21[7]);

butterfly b12 ( .x1(xtemp_2[0]), .y1(ytemp_2[0]), .x2(xtemp_2[4]), .y2(ytemp_2[4]), .xout1(xtemp_3[0]), .yout1(ytemp_3[0]), .xout2(xtemp_3[4]), .yout2(ytemp_3[4]));
butterfly b13 ( .x1(xtemp_2[1]), .y1(ytemp_2[1]), .x2(xtemp_21[5]), .y2(ytemp_21[5]), .xout1(xtemp_3[1]), .yout1(ytemp_3[1]), .xout2(xtemp_3[5]), .yout2(ytemp_3[5]));
butterfly b14 ( .x1(xtemp_2[2]), .y1(ytemp_2[2]), .x2(xtemp_21[6]), .y2(ytemp_21[6]), .xout1(xtemp_3[2]), .yout1(ytemp_3[2]), .xout2(xtemp_3[6]), .yout2(ytemp_3[6]));
butterfly b15 ( .x1(xtemp_2[3]), .y1(ytemp_2[3]), .x2(xtemp_21[7]), .y2(ytemp_21[7]), .xout1(xtemp_3[3]), .yout1(ytemp_3[3]), .xout2(xtemp_3[7]), .yout2(ytemp_3[7]));

assign xout = {xtemp_3[7],xtemp_3[6],xtemp_3[5],xtemp_3[4],xtemp_3[3],xtemp_3[2],xtemp_3[1],xtemp_3[0]};
assign yout = {ytemp_3[7],ytemp_3[6],ytemp_3[5],ytemp_3[4],ytemp_3[3],ytemp_3[2],ytemp_3[1],ytemp_3[0]};




endmodule

