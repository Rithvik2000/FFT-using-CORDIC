

/*
This Main Module takes 8 Real Inputs and 8 Imaginary Inputs each of 16 bits and 
Calculate 8-point Fast Forier Transform and store Output in 16 Different registers each of 16 bits
8 for Real Part and 8 for Imaginary Output, clock we will Take From FPGA Board itself 

We have Created 12 Instances of Butterfly Module as per DIT FFT algorithm,
and 5 Instances for Multiplication of Butterfly Results with Twiddle FACTOR.

For angle of Each Twiddle factor there is a Lookup Table Already Declared as (angle_lut)
*/






//module main_cordic_fft(xin1,xin2,xin3,xin4,xin5,xin6,xin7,xin8,
//                       yin1,yin2,yin3,yin4,yin5,yin6,yin7,yin8,
//                       xout,yout,clock,en);

//	input signed [15:0] xin1,xin2,xin3,xin4,xin5,xin6,xin7,xin8;
//	input signed [15:0] yin1,yin2,yin3,yin4,yin5,yin6,yin7,yin8;
	
//    output signed [128:0] xout;
//    output signed [128:0] yout;
    
//    input clock,en;
    
 
    
//    wire signed[31:0] angle_lut [0:3];
//    wire signed[15:0] xtemp_in[0:7],ytemp_in[0:7];
//    wire signed[15:0] xtemp_1[0:7],ytemp_1[0:7],xtemp_2[0:7],ytemp_2[0:7],xtemp_3[0:7],ytemp_3[0:7], xtemp_11[0:7],ytemp_11[0:7], xtemp_21[0:7],ytemp_21[0:7];
    
//    reg en1;
    
//    always@(posedge clock)
//           en1  = en; 
     
//    assign angle_lut[0] = 'b00000000000000000000000000000000;
//    assign angle_lut[1] = 'b11100000000000000000000000000000;
//    assign angle_lut[2] = 'b11000000000000000000000000000000;
//    assign angle_lut[3] = 'b10100000000000000000000000000000;
    
//  //(en1 == 1)   
//  // begin
//    assign  {xtemp_in[0],xtemp_in[1],xtemp_in[2],xtemp_in[3],xtemp_in[4],xtemp_in[5],xtemp_in[6],xtemp_in[7]} = (en == 1) ?  {xin1,xin2,xin3,xin4,xin5,xin6,xin7,xin8} : 0;
//    assign  {ytemp_in[0],ytemp_in[1],ytemp_in[2],ytemp_in[3],ytemp_in[4],ytemp_in[5],ytemp_in[6],ytemp_in[7]} = (en == 1) ?  {yin1,yin2,yin3,yin4,yin5,yin6,yin7,yin8} : 0;
//  // end
///*

//	butterfly b4(.clock(clock),.x1(xtemp_in[0]),.y1(ytemp_in[0]),.x2(xtemp_in[4]),.y2(ytemp_in[4]),.xout1(xtemp1[0]),.yout1(ytemp1[0]),.xout2(xtemp1[1]),.yout2(ytemp1[1]));
//	butterfly b5(.clock(clock),.x1(xtemp_in[2]),.y1(ytemp_in[2]),.x2(xtemp_in[6]),.y2(ytemp_in[6]),.xout1(xtemp1[2]),.yout1(ytemp1[2]),.xout2(xtemp1[3]),.yout2(ytemp1[3]));
//        butterfly b6(.clock(clock),.x1(xtemp_in[1]),.y1(ytemp_in[1]),.x2(xtemp_in[5]),.y2(ytemp_in[5]),.xout1(xtemp1[4]),.yout1(ytemp1[4]),.xout2(xtemp1[5]),.yout2(ytemp1[5]));
//	butterfly b7(.clock(clock),.x1(xtemp_in[3]),.y1(ytemp_in[3]),.x2(xtemp_in[7]),.y2(ytemp_in[7]),.xout1(xtemp1[6]),.yout1(ytemp1[6]),.xout2(xtemp1[7]),.yout2(ytemp1[7]));
	
//    cordic c7(clock,angle_lut[2],xtemp1[3],ytemp1[3],xtemp_1[3],ytemp_1[3]);
//    cordic c8(clock,angle_lut[2],xtemp1[7],ytemp1[7],xtemp_1[7],ytemp_1[7]);

//	butterfly b8(.clock(clock),.x1(xtemp1[0]),.y1(ytemp1[0]),.x2(xtemp1[2]),.y2(ytemp1[2]),.xout1(xtemp2[0]),.yout1(ytemp2[0]),.xout2(xtemp2[2]),.yout2(ytemp2[2]));
//	butterfly b9(.clock(clock),.x1(xtemp1[1]),.y1(ytemp1[1]),.x2(xtemp_1[3]),.y2(ytemp_1[3]),.xout1(xtemp2[1]),.yout1(ytemp2[1]),.xout2(xtemp2[3]),.yout2(ytemp2[3]));
//        butterfly b10(.clock(clock),.x1(xtemp1[4]),.y1(ytemp1[4]),.x2(xtemp1[6]),.y2(ytemp1[6]),.xout1(xtemp2[4]),.yout1(ytemp2[4]),.xout2(xtemp2[6]), .yout2(ytemp2[6]));
//	butterfly b11(.clock(clock),.x1(xtemp1[5]),.y1(ytemp1[5]),.x2(xtemp_1[7]),.y2(ytemp_1[7]),.xout1(xtemp2[5]),.yout1(ytemp2[5]),.xout2(xtemp2[7]),.yout2(ytemp2[7]));

//    cordic c9(clock,angle_lut[1],xtemp2[5],ytemp2[5],xtemp_2[5],ytemp_2[5]);
//    cordic c10(clock,angle_lut[2],xtemp2[6],ytemp2[6],xtemp_2[6],ytemp_2[6]);
//    cordic c11(clock,angle_lut[3],xtemp2[7],ytemp2[7],xtemp_2[7],ytemp_2[7]);

//	butterfly b12(.clock(clock),.x1(xtemp2[0]),.y1(ytemp2[0]),.x2(xtemp2[4]),.y2(ytemp2[4]),.xout1(xtemp3[0]),.yout1(ytemp3[0]),.xout2(xtemp3[4]),.yout2(ytemp3[4]));
//	butterfly b13(.clock(clock),.x1(xtemp2[1]),.y1(ytemp2[1]),.x2(xtemp_2[5]),.y2(ytemp_2[5]),.xout1(xtemp3[1]),.yout1(ytemp3[1]),.xout2(xtemp3[5]),.yout2(ytemp3[5]));
//        butterfly b14(.clock(clock),.x1(xtemp2[2]),.y1(ytemp2[2]),.x2(xtemp_2[6]),.y2(ytemp_2[6]),.xout1(xtemp3[2]),.yout1(ytemp3[2]),.xout2(xtemp3[6]),.yout2(ytemp3[6]));
//	butterfly b15(.clock(clock),.x1(xtemp2[3]),.y1(ytemp2[3]),.x2(xtemp_2[7]),.y2(ytemp_2[7]),.xout1(xtemp3[3]),.yout1(ytemp3[3]),.xout2(xtemp3[7]),.yout2(ytemp3[7]));
//*/


//butterfly b4 (.clock(clock), .x1(xin1), .y1(yin1), .x2(xin5), .y2(yin5), .xout1(xtemp_1[0]), .yout1(ytemp_1[0]), .xout2(xtemp_1[1]), .yout2(ytemp_1[1]));
//butterfly b5 (.clock(clock), .x1(xin3), .y1(yin3), .x2(xin7), .y2(yin7), .xout1(xtemp_1[2]), .yout1(ytemp_1[2]), .xout2(xtemp_1[3]), .yout2(ytemp_1[3]));
//butterfly b6 (.clock(clock), .x1(xin2), .y1(yin2), .x2(xin6), .y2(yin6), .xout1(xtemp_1[4]), .yout1(ytemp_1[4]), .xout2(xtemp_1[5]), .yout2(ytemp_1[5]));
//butterfly b7 (.clock(clock), .x1(xin4), .y1(yin4), .x2(xin8), .y2(yin8), .xout1(xtemp_1[6]), .yout1(ytemp_1[6]), .xout2(xtemp_1[7]), .yout2(ytemp_1[7]));

//cordic c7(clock,angle_lut[2],xtemp_1[3],ytemp_1[3],xtemp_11[3],ytemp_11[3]);
//cordic c8(clock,angle_lut[2],xtemp_1[7],ytemp_1[7],xtemp_11[7],ytemp_11[7]);

//butterfly b8  (.clock(clock), .x1(xtemp_1[0]), .y1(ytemp_1[0]), .x2(xtemp_1[2]), .y2(ytemp_1[2]), .xout1(xtemp_2[0]), .yout1(ytemp_2[0]), .xout2(xtemp_2[2]), .yout2(ytemp_2[2]));
//butterfly b9  (.clock(clock), .x1(xtemp_1[1]), .y1(ytemp_1[1]), .x2(xtemp_11[3]), .y2(ytemp_11[3]), .xout1(xtemp_2[1]), .yout1(ytemp_2[1]), .xout2(xtemp_2[3]), .yout2(ytemp_2[3]));
//butterfly b10 (.clock(clock), .x1(xtemp_1[4]), .y1(ytemp_1[4]), .x2(xtemp_1[6]), .y2(ytemp_1[6]), .xout1(xtemp_2[4]), .yout1(ytemp_2[4]), .xout2(xtemp_2[6]), .yout2(ytemp_2[6]));
//butterfly b11 (.clock(clock), .x1(xtemp_1[5]), .y1(ytemp_1[5]), .x2(xtemp_11[7]), .y2(ytemp_11[7]), .xout1(xtemp_2[5]), .yout1(ytemp_2[5]), .xout2(xtemp_2[7]), .yout2(ytemp_2[7]));

//cordic c9 (clock,angle_lut[1],xtemp_2[5],ytemp_2[5],xtemp_21[5],ytemp_21[5]);
//cordic c10(clock,angle_lut[2],xtemp_2[6],ytemp_2[6],xtemp_21[6],ytemp_21[6]);
//cordic c11(clock,angle_lut[3],xtemp_2[7],ytemp_2[7],xtemp_21[7],ytemp_21[7]);

//butterfly b12 (.clock(clock), .x1(xtemp_2[0]), .y1(ytemp_2[0]), .x2(xtemp_2[4]), .y2(ytemp_2[4]), .xout1(xtemp_3[0]), .yout1(ytemp_3[0]), .xout2(xtemp_3[4]), .yout2(ytemp_3[4]));
//butterfly b13 (.clock(clock), .x1(xtemp_2[1]), .y1(ytemp_2[1]), .x2(xtemp_21[5]), .y2(ytemp_21[5]), .xout1(xtemp_3[1]), .yout1(ytemp_3[1]), .xout2(xtemp_3[5]), .yout2(ytemp_3[5]));
//butterfly b14 (.clock(clock), .x1(xtemp_2[2]), .y1(ytemp_2[2]), .x2(xtemp_21[6]), .y2(ytemp_21[6]), .xout1(xtemp_3[2]), .yout1(ytemp_3[2]), .xout2(xtemp_3[6]), .yout2(ytemp_3[6]));
//butterfly b15 (.clock(clock), .x1(xtemp_2[3]), .y1(ytemp_2[3]), .x2(xtemp_21[7]), .y2(ytemp_21[7]), .xout1(xtemp_3[3]), .yout1(ytemp_3[3]), .xout2(xtemp_3[7]), .yout2(ytemp_3[7]));

//assign xout = {xtemp_3[7],xtemp_3[6],xtemp_3[5],xtemp_3[4],xtemp_3[3],xtemp_3[2],xtemp_3[1],xtemp_3[0]};
//assign yout = {ytemp_3[7],ytemp_3[6],ytemp_3[5],ytemp_3[4],ytemp_3[3],ytemp_3[2],ytemp_3[1],ytemp_3[0]};




//endmodule


///* Simple Butterfly Module to Calculate 2 Radix Which were used in DIT/DIF FFT algorithms */


//module butterfly(
//	input clock,
//	input signed [15:0] x1,
//	input signed [15:0] y1,
//	input signed [15:0] x2,
//	input signed [15:0] y2,
//	output signed [15:0] xout1,
//	output signed [15:0] yout1,
//	output signed [15:0] xout2,
//	output signed [15:0] yout2 );


//assign xout1 = x1+x2;
//assign yout1 = y1+y2;

//assign xout2 = x1-x2;
//assign yout2 = y1-y2;

//endmodule

///*
//CORDIC Module will be Used to calculate value of twiddle Factor which have been used in FFT,
//as a Input it takes two 16 bit Number i.e Xin1 & Yin1 one for Real part and one for Imaginary Part
//and one input is theta (angle) 

//It will Give Two Output of 16 bit one for real part and another for Imaginary as Follows
//    Xout = Xin1*cos(angle)+Xin1*sin(angle);  // Real Part
//    Yout = Yin1*cos(angle)+Yin1*sin(angle);  // Imaginary Part
//*/




////////////////////////////////////////////////////////////////////

/*
module Eight_pt_fft (xin1,xin2,xin3,xin4,xin5,xin6,xin7,xin8,
                       yin1,yin2,yin3,yin4,yin5,yin6,yin7,yin8,
                       xout,yout,clock,en);

	input signed [15:0] xin1,xin2,xin3,xin4,xin5,xin6,xin7,xin8;
	input signed [15:0] yin1,yin2,yin3,yin4,yin5,yin6,yin7,yin8;
	
    output signed [128:0] xout;
    output signed [128:0] yout;
    
    input clock,en;
    
 
    
    wire signed[31:0] angle_lut [0:3];
    wire  signed[15:0] xtemp_in[0:7],ytemp_in[0:7];
    wire signed[15:0] xtemp_1[0:7],ytemp_1[0:7],xtemp_2[0:7],ytemp_2[0:7],xtemp_3[0:7],ytemp_3[0:7], xtemp_11[0:7],ytemp_11[0:7], xtemp_21[0:7],ytemp_21[0:7];
    
    reg en1;
    
    always@(posedge clock)
           en1  = en; 
     
    assign angle_lut[0] = 'b0_00_00000000000000000000000000000; //0
    assign angle_lut[1] = 'b1_11_00000000000000000000000000000;  // -4 + 3 = -1
    assign angle_lut[2] = 'b1_10_00000000000000000000000000000;  // -4 + 2 = -2
    assign angle_lut[3] = 'b1_01_00000000000000000000000000000;  // -4 + 1 = -3
    
  //(en1 == 1)   
  // begin
    assign  {xtemp_in[0],xtemp_in[1],xtemp_in[2],xtemp_in[3],xtemp_in[4],xtemp_in[5],xtemp_in[6],xtemp_in[7]} = (en == 1) ?  {xin1,xin2,xin3,xin4,xin5,xin6,xin7,xin8} : 0;
    assign  {ytemp_in[0],ytemp_in[1],ytemp_in[2],ytemp_in[3],ytemp_in[4],ytemp_in[5],ytemp_in[6],ytemp_in[7]} = (en == 1) ?  {yin1,yin2,yin3,yin4,yin5,yin6,yin7,yin8} : 0;
  // end


butterfly b4 (.clock(clock), .x1(xin1), .y1(yin1), .x2(xin2), .y2(yin5), .xout1(xtemp_1[0]), .yout1(ytemp_1[0]), .xout2(xtemp_1[1]), .yout2(ytemp_1[1]));
butterfly b5 (.clock(clock), .x1(xin3), .y1(yin3), .x2(xin4), .y2(yin7), .xout1(xtemp_1[2]), .yout1(ytemp_1[2]), .xout2(xtemp_1[3]), .yout2(ytemp_1[3]));
butterfly b6 (.clock(clock), .x1(xin5), .y1(yin2), .x2(xin6), .y2(yin6), .xout1(xtemp_1[4]), .yout1(ytemp_1[4]), .xout2(xtemp_1[5]), .yout2(ytemp_1[5]));
butterfly b7 (.clock(clock), .x1(xin7), .y1(yin4), .x2(xin8), .y2(yin8), .xout1(xtemp_1[6]), .yout1(ytemp_1[6]), .xout2(xtemp_1[7]), .yout2(ytemp_1[7]));

cordic c7(clock,angle_lut[2],xtemp_1[3],ytemp_1[3],xtemp_11[3],ytemp_11[3]);
cordic c8(clock,angle_lut[2],xtemp_1[7],ytemp_1[7],xtemp_11[7],ytemp_11[7]);

butterfly b8  (.clock(clock), .x1(xtemp_1[0]), .y1(ytemp_1[0]), .x2(xtemp_1[2]), .y2(ytemp_1[2]), .xout1(xtemp_2[0]), .yout1(ytemp_2[0]), .xout2(xtemp_2[2]), .yout2(ytemp_2[2]));
butterfly b9  (.clock(clock), .x1(xtemp_1[1]), .y1(ytemp_1[1]), .x2(xtemp_11[3]), .y2(ytemp_11[3]), .xout1(xtemp_2[1]), .yout1(ytemp_2[1]), .xout2(xtemp_2[3]), .yout2(ytemp_2[3]));
butterfly b10 (.clock(clock), .x1(xtemp_1[4]), .y1(ytemp_1[4]), .x2(xtemp_1[6]), .y2(ytemp_1[6]), .xout1(xtemp_2[4]), .yout1(ytemp_2[4]), .xout2(xtemp_2[6]), .yout2(ytemp_2[6]));
butterfly b11 (.clock(clock), .x1(xtemp_1[5]), .y1(ytemp_1[5]), .x2(xtemp_11[7]), .y2(ytemp_11[7]), .xout1(xtemp_2[5]), .yout1(ytemp_2[5]), .xout2(xtemp_2[7]), .yout2(ytemp_2[7]));

cordic c9 (clock,angle_lut[1],xtemp_2[5],ytemp_2[5],xtemp_21[5],ytemp_21[5]);
cordic c10(clock,angle_lut[2],xtemp_2[6],ytemp_2[6],xtemp_21[6],ytemp_21[6]);
cordic c11(clock,angle_lut[3],xtemp_2[7],ytemp_2[7],xtemp_21[7],ytemp_21[7]);

butterfly b12 (.clock(clock), .x1(xtemp_2[0]), .y1(ytemp_2[0]), .x2(xtemp_2[4]), .y2(ytemp_2[4]), .xout1(xtemp_3[0]), .yout1(ytemp_3[0]), .xout2(xtemp_3[4]), .yout2(ytemp_3[4]));
butterfly b13 (.clock(clock), .x1(xtemp_2[1]), .y1(ytemp_2[1]), .x2(xtemp_21[5]), .y2(ytemp_21[5]), .xout1(xtemp_3[1]), .yout1(ytemp_3[1]), .xout2(xtemp_3[5]), .yout2(ytemp_3[5]));
butterfly b14 (.clock(clock), .x1(xtemp_2[2]), .y1(ytemp_2[2]), .x2(xtemp_21[6]), .y2(ytemp_21[6]), .xout1(xtemp_3[2]), .yout1(ytemp_3[2]), .xout2(xtemp_3[6]), .yout2(ytemp_3[6]));
butterfly b15 (.clock(clock), .x1(xtemp_2[3]), .y1(ytemp_2[3]), .x2(xtemp_21[7]), .y2(ytemp_21[7]), .xout1(xtemp_3[3]), .yout1(ytemp_3[3]), .xout2(xtemp_3[7]), .yout2(ytemp_3[7]));

assign xout = {xtemp_3[7],xtemp_3[6],xtemp_3[5],xtemp_3[4],xtemp_3[3],xtemp_3[2],xtemp_3[1],xtemp_3[0]};
assign yout = {ytemp_3[7],ytemp_3[6],ytemp_3[5],ytemp_3[4],ytemp_3[3],ytemp_3[2],ytemp_3[1],ytemp_3[0]};




endmodule

*/
