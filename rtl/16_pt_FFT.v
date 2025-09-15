

module sixteen_pt_FFT( x_in0,
                       x_in1,
                       x_in2,
                       x_in3,
                       x_in4,
                       x_in5,
                       x_in6,
                       x_in7,
                       x_in8,
                       x_in9,
                       x_in10,
                       x_in11,
                       x_in12,
                       x_in13,
                       x_in14,
                       x_in15,
                       y_in0,
                       y_in1,
                       y_in2,
                       y_in3,
                       y_in4,
                       y_in5,
                       y_in6,
                       y_in7,
                       y_in8,
                       y_in9,
                       y_in10,
                       y_in11,
                       y_in12,
                       y_in13,
                       y_in14,
                       y_in15,
                       x_out_final,
                       y_out_final,
                       clock,en
                       
                     );
    
    
input wire signed [15:0] x_in0;
input wire signed [15:0] x_in1;
input wire signed [15:0] x_in2;
input wire signed [15:0] x_in3;
input wire signed [15:0] x_in4;
input wire signed [15:0] x_in5;
input wire signed [15:0] x_in6;
input wire signed [15:0] x_in7;
input wire signed [15:0] x_in8;
input wire signed [15:0] x_in9;
input wire signed [15:0] x_in10;
input wire signed [15:0] x_in11;
input wire signed [15:0] x_in12;
input wire signed [15:0] x_in13;
input wire signed [15:0] x_in14;
input wire signed [15:0] x_in15;

input wire signed [15:0] y_in0;
input wire signed [15:0] y_in1;
input wire signed [15:0] y_in2;
input wire signed [15:0] y_in3;
input wire signed [15:0] y_in4;
input wire signed [15:0] y_in5;
input wire signed [15:0] y_in6;
input wire signed [15:0] y_in7;
input wire signed [15:0] y_in8;
input wire signed [15:0] y_in9;
input wire signed [15:0] y_in10;
input wire signed [15:0] y_in11;
input wire signed [15:0] y_in12;
input wire signed [15:0] y_in13;
input wire signed [15:0] y_in14;
input wire signed [15:0] y_in15;

input clock, en;
    
output wire  [255:0] x_out_final, y_out_final;
    
    wire signed[15:0] x_out[15:0];
    wire signed[15:0] y_out[15:0];
    wire signed[15:0] x_temp[15:0];
    wire signed[15:0] y_temp[15:0];
    wire signed[15:0] x_temp_2[15:0];
    wire signed[15:0] y_temp_2[15:0];
    
    wire [127:0] x_out_1, x_out_2, y_out_1, y_out_2;
    
    wire signed[31:0] angle_lut [0:7];
    
    assign angle_lut[0] = 32'b00_0000000000000000000000000000000;  //   W 0_16
    assign angle_lut[1] = 32'b00_01_0000000000000000000000000000;  //   W 1_16
    assign angle_lut[2] = 32'b00_10_0000000000000000000000000000;  //   W 2_16
    assign angle_lut[3] = 32'b00_11_0000000000000000000000000000;  //   W 3_16
    
    assign angle_lut[4] = 32'b01_00_0000000000000000000000000000;  //   W 4_16
    assign angle_lut[5] = 32'b01_01_0000000000000000000000000000;  //   W 5_16
    assign angle_lut[6] = 32'b01_10_0000000000000000000000000000;  //   W 6_16
    assign angle_lut[7] = 32'b01_11_0000000000000000000000000000;  //   W 7_16
    
   Eight_pt_fft f8_1 (
    x_in0, x_in8, x_in4, x_in12, x_in2, x_in10, x_in6, x_in14,
    y_in0, y_in8, y_in4, y_in12, y_in2, y_in10, y_in6, y_in14,
    x_out_1,
    y_out_1,
    clock,en
);

Eight_pt_fft f8_2 (
    x_in1, x_in9, x_in5, x_in13, x_in3, x_in11, x_in7, x_in15,
    y_in1, y_in9, y_in5, y_in13, y_in3, y_in11, y_in7, y_in15,
    x_out_2,
    y_out_2,
    clock,en
);


assign x_out[0] = x_out_1[15:0];
assign x_out[1] = x_out_1[31:16];
assign x_out[2] = x_out_1[47:32];
assign x_out[3] = x_out_1[63:48];
assign x_out[4] = x_out_1[79:64];
assign x_out[5] = x_out_1[95:80];
assign x_out[6] = x_out_1[111:96];
assign x_out[7] = x_out_1[127:112];

assign y_out[0] = y_out_1[15:0];
assign y_out[1] = y_out_1[31:16];
assign y_out[2] = y_out_1[47:32];
assign y_out[3] = y_out_1[63:48];
assign y_out[4] = y_out_1[79:64];
assign y_out[5] = y_out_1[95:80];
assign y_out[6] = y_out_1[111:96];
assign y_out[7] = y_out_1[127:112];

assign x_out[8] = x_out_2[15:0];
assign x_out[9] = x_out_2[31:16];
assign x_out[10] = x_out_2[47:32];
assign x_out[11] = x_out_2[63:48];
assign x_out[12] = x_out_2[79:64];
assign x_out[13] = x_out_2[95:80];
assign x_out[14] = x_out_2[111:96];
assign x_out[15] = x_out_2[127:112];

assign y_out[8] = y_out_2[15:0];
assign y_out[9] = y_out_2[31:16];
assign y_out[10] = y_out_2[47:32];
assign y_out[11] = y_out_2[63:48];
assign y_out[12] = y_out_2[79:64];
assign y_out[13] = y_out_2[95:80];
assign y_out[14] = y_out_2[111:96];
assign y_out[15] = y_out_2[127:112];



    
    
    cordic a1 (clock,angle_lut[1],x_out[9], y_out[9], x_temp[9],y_temp[9]);
    cordic a2 (clock,angle_lut[2],x_out[10],y_out[10],x_temp[10],y_temp[10]);
    cordic a3 (clock,angle_lut[3],x_out[11],y_out[11],x_temp[11],y_temp[11]);
    cordic a4 (clock,angle_lut[4],x_out[12],y_out[12],x_temp[12],y_temp[12]);
    cordic a5 (clock,angle_lut[5],x_out[13],y_out[13],x_temp[13],y_temp[13]);
    cordic a6 (clock,angle_lut[6],x_out[14],y_out[14],x_temp[14],y_temp[14]);
    cordic a7 (clock,angle_lut[7],x_out[15],y_out[15],x_temp[15],y_temp[15]);
    

butterfly bb1 ( .x1(x_out[0]), .y1(y_out[0]), .x2(x_out[8]), .y2(y_out[8]), .xout1(x_temp_2[0]), .yout1(y_temp_2[0]), .xout2(x_temp_2[8]), .yout2(y_temp_2[8]));
butterfly bb2 ( .x1(x_out[1]), .y1(y_out[1]), .x2(x_temp[9]), .y2(y_temp[9]), .xout1(x_temp_2[1]), .yout1(y_temp_2[1]), .xout2(x_temp_2[9]), .yout2(y_temp_2[9]));
butterfly bb3 ( .x1(x_out[2]), .y1(y_out[2]), .x2(x_temp[10]), .y2(y_temp[10]), .xout1(x_temp_2[2]), .yout1(y_temp_2[2]), .xout2(x_temp_2[10]), .yout2(y_temp_2[10]));
butterfly bb4 ( .x1(x_out[3]), .y1(y_out[3]), .x2(x_temp[11]), .y2(y_temp[11]), .xout1(x_temp_2[3]), .yout1(y_temp_2[3]), .xout2(x_temp_2[11]), .yout2(y_temp_2[11]));
butterfly bb5 ( .x1(x_out[4]), .y1(y_out[4]), .x2(x_temp[12]), .y2(y_temp[12]), .xout1(x_temp_2[4]), .yout1(y_temp_2[4]), .xout2(x_temp_2[12]), .yout2(y_temp_2[12]));
butterfly bb6 ( .x1(x_out[5]), .y1(y_out[5]), .x2(x_temp[13]), .y2(y_temp[13]), .xout1(x_temp_2[5]), .yout1(y_temp_2[5]), .xout2(x_temp_2[13]), .yout2(y_temp_2[13]));
butterfly bb7 ( .x1(x_out[6]), .y1(y_out[6]), .x2(x_temp[14]), .y2(y_temp[14]), .xout1(x_temp_2[6]), .yout1(y_temp_2[6]), .xout2(x_temp_2[14]), .yout2(y_temp_2[14]));
butterfly bb8 ( .x1(x_out[7]), .y1(y_out[7]), .x2(x_temp[15]), .y2(y_temp[15]), .xout1(x_temp_2[7]), .yout1(y_temp_2[7]), .xout2(x_temp_2[15]), .yout2(y_temp_2[15]));


assign x_out_final = {x_temp_2[15], x_temp_2[14], x_temp_2[13], x_temp_2[12],
                      x_temp_2[11], x_temp_2[10], x_temp_2[9],  x_temp_2[8],
                      x_temp_2[7],  x_temp_2[6],  x_temp_2[5],  x_temp_2[4],
                      x_temp_2[3],  x_temp_2[2],  x_temp_2[1],  x_temp_2[0]};
                      
assign y_out_final = {y_temp_2[15], y_temp_2[14], y_temp_2[13], y_temp_2[12],
                      y_temp_2[11], y_temp_2[10], y_temp_2[9],  y_temp_2[8],
                      y_temp_2[7],  y_temp_2[6],  y_temp_2[5],  y_temp_2[4],
                      y_temp_2[3],  y_temp_2[2],  y_temp_2[1],  y_temp_2[0]};




endmodule
