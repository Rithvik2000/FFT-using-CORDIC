`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////



module FFT_top_tb;

  parameter DATA_WIDTH = 16;
  parameter SEQ_LENGTH = 16;

  // Testbench signals
  reg clk;
  reg reset_n;
  reg [DATA_WIDTH-1:0] data_in_real;
  reg [DATA_WIDTH-1:0] data_in_img;
  reg valid_in;
  wire [DATA_WIDTH-1:0] data_out_real;
  wire [DATA_WIDTH-1:0] data_out_img;
  wire done;

  // Instantiate the DUT (Device Under Test)
  FFT_top dut (
    .clk(clk),
    .reset_n(reset_n),
    .data_in_real(data_in_real),
    .data_in_img(data_in_img),
    .valid_in(valid_in),
    .data_out_real(data_out_real),
    .data_out_img(data_out_img),
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

    // Apply reset
    #24;
    reset_n = 1;
    data_in_real = 128;
    data_in_img = 128;
    
    // Feed SEQ_LENGTH complex samples
    repeat (SEQ_LENGTH) begin
      @(posedge clk);
      #8
      data_in_real = data_in_img  ;
      data_in_img  =  data_in_img;
      valid_in = 1;
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
    $monitor("T=%0t | in_real=%d | in_img=%d | out_real=%d | out_img=%d | done=%b",
              $time, data_in_real, data_in_img, data_out_real, data_out_img, done);
  end

endmodule