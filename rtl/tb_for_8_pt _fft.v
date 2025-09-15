`timescale 1ns / 1ps

module Eight_pt_fft_tb;

  reg clock, en;
  reg signed [15:0] xin[0:7], yin[0:7];
  wire signed [128:0] xout, yout;

  // Individual output wires for waveform visibility
  wire signed [15:0] xout0, xout1, xout2, xout3, xout4, xout5, xout6, xout7;
  wire signed [15:0] yout0, yout1, yout2, yout3, yout4, yout5, yout6, yout7;

  // Instantiate the FFT module
  Eight_pt_fft uut (
    .xin1(xin[0]), .xin2(xin[1]), .xin3(xin[2]), .xin4(xin[3]),
    .xin5(xin[4]), .xin6(xin[5]), .xin7(xin[6]), .xin8(xin[7]),
    .yin1(yin[0]), .yin2(yin[1]), .yin3(yin[2]), .yin4(yin[3]),
    .yin5(yin[4]), .yin6(yin[5]), .yin7(yin[6]), .yin8(yin[7]),
    .xout(xout), .yout(yout),
    .clock(clock), .en(en)
  );

  // Clock generation
  initial clock = 0;
  always #5 clock = ~clock;

  // Output slicing
  assign xout0 = xout[15:0];
  assign xout1 = xout[31:16];
  assign xout2 = xout[47:32];
  assign xout3 = xout[63:48];
  assign xout4 = xout[79:64];
  assign xout5 = xout[95:80];
  assign xout6 = xout[111:96];
  assign xout7 = xout[127:112];

  assign yout0 = yout[15:0];
  assign yout1 = yout[31:16];
  assign yout2 = yout[47:32];
  assign yout3 = yout[63:48];
  assign yout4 = yout[79:64];
  assign yout5 = yout[95:80];
  assign yout6 = yout[111:96];
  assign yout7 = yout[127:112];

  // Stimulus
  initial begin
    $display("Starting FFT Testbench...");
    en = 0;

    // Initialize input samples (e.g., cosine wave)
    xin[0] = 16'sd256;   yin[0] = 16'sd256;
    xin[1] = 16'sd0;   yin[1] = 16'sd0;
    xin[2] = 16'sd0;   yin[2] = 16'sd0;
    xin[3] = 16'sd0;   yin[3] = 16'sd0;
    xin[4] = 16'sd0;   yin[4] = 16'sd0;
    xin[5] = 16'sd0;   yin[5] = 16'sd0;
    xin[6] = 16'sd0;   yin[6] = 16'sd0;
    xin[7] = 16'sd0;   yin[7] = 16'sd0;

    #20 en = 1;

    #1000;

    // Display individual outputs
    $display("FFT Output X:");
    $display("X[0] = %d", xout0);
    $display("X[1] = %d", xout1);
    $display("X[2] = %d", xout2);
    $display("X[3] = %d", xout3);
    $display("X[4] = %d", xout4);
    $display("X[5] = %d", xout5);
    $display("X[6] = %d", xout6);
    $display("X[7] = %d", xout7);

    $display("FFT Output Y:");
    $display("Y[0] = %d", yout0);
    $display("Y[1] = %d", yout1);
    $display("Y[2] = %d", yout2);
    $display("Y[3] = %d", yout3);
    $display("Y[4] = %d", yout4);
    $display("Y[5] = %d", yout5);
    $display("Y[6] = %d", yout6);
    $display("Y[7] = %d", yout7);

    $finish;
  end

endmodule
