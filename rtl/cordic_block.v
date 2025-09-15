module cordic(
   
  
   
   input  clock,
  // input reset,
   input  signed  [31:0] angle,
   input  signed  [15:0] Xin1,
   input  signed  [15:0] Yin1,
   output signed  [15 :0] Xout,
   output signed  [15 :0] Yout
   
   );
   
   localparam DATA_WIDTH = 16; 
   localparam ITERATIONS = 16 ;
   
   wire signed [DATA_WIDTH -1:0] Xin;
   wire signed [DATA_WIDTH -1:0] Yin;
   
   // Approximates CORDIC gain compensation, reducing Xin1 and Yin1 by an empirically derived factor.

   assign Xin = (Xin1>>>1)+(Xin1>>>4)+(Xin1>>>5)+(Xin1>>>6);  // x0.609
   assign Yin = (Yin1>>>1)+(Yin1>>>4)+(Yin1>>>5)+(Yin1>>>6);
     
   wire signed [31:0] atan_table [0:30];
   //  00100...0  = 45 degrees
   //  Precomputed arctangent values in radians, fixed-point format, used in each iteration.  
   assign atan_table[00] = 32'b001_00000000000000000000000000000;       // first 2 msb bits represent quardrant
   assign atan_table[01] = 32'b000_10010111001000000010100011101;
   assign atan_table[02] = 32'b000_01001111110110011100001011011; 
   assign atan_table[03] = 32'b000_00101000100010001000111010100; 
   assign atan_table[04] = 32'b000_00010100010110000110101000011;
   assign atan_table[05] = 32'b000_00001010001011101011111100001;
   assign atan_table[06] = 32'b000_00000101000101111011000011110;
   assign atan_table[07] = 32'b000_00000010100010111110001010101;
   assign atan_table[08] = 32'b000_00000001010001011111001010011;
   assign atan_table[09] = 32'b000_00000000101000101111100101110;
   assign atan_table[10] = 32'b000_00000000010100010111110011000;
   assign atan_table[11] = 32'b00000000000001010001011111001100;
   assign atan_table[12] = 32'b00000000000000101000101111100110;
   assign atan_table[13] = 32'b00000000000000010100010111110011;
   assign atan_table[14] = 32'b00000000000000001010001011111001;
   assign atan_table[15] = 32'b00000000000000000101000101111101;
   assign atan_table[16] = 32'b00000000000000000010100010111110;
   assign atan_table[17] = 32'b00000000000000000001010001011111;
   assign atan_table[18] = 32'b00000000000000000000101000101111;
   assign atan_table[19] = 32'b00000000000000000000010100011000;
   assign atan_table[20] = 32'b00000000000000000000001010001100;
   assign atan_table[21] = 32'b00000000000000000000000101000110;
   assign atan_table[22] = 32'b00000000000000000000000010100011;
   assign atan_table[23] = 32'b00000000000000000000000001010001;
   assign atan_table[24] = 32'b00000000000000000000000000101000;
   assign atan_table[25] = 32'b00000000000000000000000000010100;
   assign atan_table[26] = 32'b00000000000000000000000000001010;
   assign atan_table[27] = 32'b00000000000000000000000000000101;
   assign atan_table[28] = 32'b00000000000000000000000000000010;
   assign atan_table[29] = 32'b00000000000000000000000000000001; 
   assign atan_table[30] = 32'b00000000000000000000000000000000;
   
   reg signed [DATA_WIDTH-1 :0] X [0:ITERATIONS-1];
   reg signed [DATA_WIDTH-1 :0] Y [0:ITERATIONS-1];
   
   reg signed    [31:0] Z [0:ITERATIONS-1]; 
   wire [1:0] quadrant;
   
   assign quadrant = angle[31:30];
    
 always @(posedge clock) begin
//  if (reset) begin
//    X[0] <= 0;
//    Y[0] <= 0;
//    Z[0] <= 0;
//  end else
  begin
    case (quadrant)
      2'b00, 2'b11: begin
        X[0] <= Xin;
        Y[0] <= Yin;
        Z[0] <= angle;
      end

      2'b01: begin
        X[0] <= {-Yin };
        Y[0] <= Xin;
        Z[0] <= {2'b00, angle[29:0]};  // Angle remapped to 1st quadrant
      end

      2'b10: begin
        X[0] <= Yin;
        Y[0] <= -Xin;
        Z[0] <= {2'b00, angle[29:0]};  // Angle remapped to 1st quadrant
      end

      default: begin
        X[0] <= 0;
        Y[0] <= 0;
        Z[0] <= 0;
      end
    endcase
  end
end
  
   genvar i;

   generate
     for (i=0; i < (ITERATIONS-1); i=i+1)
        begin
           wire  Z_sign;
           wire signed  [DATA_WIDTH-1 :0] X_shr, Y_shr; 
   
           assign X_shr = X[i] >>> i; 
           assign Y_shr = Y[i] >>> i;
   
           assign Z_sign = Z[i][31]; 
   
           always @(posedge clock)
             begin
               X[i+1] <= Z_sign ? X[i] + Y_shr         : X[i] - Y_shr;
               Y[i+1] <= Z_sign ? Y[i] - X_shr         : Y[i] + X_shr;
               Z[i+1] <= Z_sign ? Z[i] + atan_table[i] : Z[i] - atan_table[i];
           end
        end
         
   endgenerate
   
   
   
   assign Xout = X[ITERATIONS-1];
   assign Yout = Y[ITERATIONS-1];
   
endmodule
