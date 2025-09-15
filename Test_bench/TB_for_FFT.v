`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////



module FFT_top_tb;

  parameter DATA_WIDTH = 16;
  parameter SEQ_LENGTH =16;

  // Testbench signals
  reg clk;
  reg reset_n;
  reg valid_in;
  
  wire valid_out;
  wire done;
  
  reg [DATA_WIDTH-1:0] data_in_real;
  reg [DATA_WIDTH-1:0] data_in_img;
  
  wire [DATA_WIDTH-1:0] data_out_real;
  wire [DATA_WIDTH-1:0] data_out_img;
  
  
  reg signed [15:0] fixed_real [0:15];
  reg signed [15:0] fixed_img  [0:15];
 integer i1;

  // Instantiate the DUT (Device Under Test)
  FFT_top dut (
    .clk(clk),
    .reset_n(reset_n),
    .data_in_real(data_in_real),
    .data_in_img(data_in_img),
    .valid_in(valid_in),
    .data_out_real(data_out_real),
    .data_out_img(data_out_img),
    .valid_out(valid_out),
    .done(done)
  );

  // Clock generation: 100 MHz
  initial clk = 1;
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    // Initialize inputs
    reset_n = 0;
    valid_in = 0;
    data_in_real = 0;
    data_in_img = 0;
        
      // fixed_real values
    fixed_real[0]  = 16'sd256;   // 1.0
    fixed_real[1]  = 16'sd256;   // 0.5
    fixed_real[2]  = 16'sd0;   // 1.0
    fixed_real[3]  = 16'sd0;   // -1.0
    fixed_real[4]  = 16'sd0;   // 2.0
    fixed_real[5]  = 16'sd0;   // 1.0
    fixed_real[6]  = 16'sd0;   // 1.0
    fixed_real[7]  = 16'sd0;     // 0.0
    fixed_real[8]  = 16'sd0;   // 1.0
    fixed_real[9]  = 16'sd0;   // 1.0
    fixed_real[10] = 16'sd0;   // 1.0
    fixed_real[11] = 16'sd0;   // -2.0
    fixed_real[12] = 16'sd0;   // 1.0
    fixed_real[13] = 16'sd0;   // 0.5
    fixed_real[14] = 16'sd0;   // 1.0
    fixed_real[15] = 16'sd0;    // 0.25

    // fixed_img values
    fixed_img[0]  = 16'sd0;   // 1.0
    fixed_img[1]  = 16'sd0;   // 1.0
    fixed_img[2]  = 16'sd0;     // 0.0
    fixed_img[3]  = 16'sd0;   // 0.5
    fixed_img[4]  = 16'sd0;   // 1.0
    fixed_img[5]  = 16'sd0;   // 1.0
    fixed_img[6]  = 16'sd0;   // 2.0
    fixed_img[7]  = 16'sd0;   // -1.0
    fixed_img[8]  = 16'sd0;    // 1.0
    fixed_img[9]  = 16'sd0;   // -0.5
    fixed_img[10] = 16'sd0;     // 0.0
    fixed_img[11] = 16'sd0;   // 1.0
    fixed_img[12] = 16'sd0;   // 0.5
    fixed_img[13] = 16'sd0;   // 1.0
    fixed_img[14] = 16'sd0;   // -1.0
    fixed_img[15] = 16'sd0;   // 4.0


    
    

    // Apply reset and make valid 1
    #29
    reset_n = 1;
    valid_in = 1;
    
 

  for (i1 = 0; i1 <= 15; i1 = i1 + 1) begin
    #10
    data_in_real = fixed_real[i1];
    data_in_img  = fixed_img[i1];
    
  end



    // Stop feeding after data stream
    @(posedge clk);
    valid_in = 0;

    // Wait for FFT computation to complete
    wait(done);

    // Finish simulation
    #200;
    $finish;
  end

  // Output monitor
  initial begin
    $monitor("T=%0t | in_real=%d | in_img=%d | out_real=%d | out_img=%d | done=%b | done=%b",
              $time, data_in_real, data_in_img, data_out_real, data_out_img, valid_out, done);
  end
  
  

  
  

endmodule