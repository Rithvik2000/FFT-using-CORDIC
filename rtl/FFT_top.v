module FFT_top #(parameter DATA_WIDTH = 16, SEQ_LENGTH = 16 )(
    input                         clk,
    input                         reset_n, // Active-low reset
    input      [DATA_WIDTH -1:0]  data_in_real,
    input      [DATA_WIDTH -1:0]  data_in_img,
    input                         valid_in,
    output reg [DATA_WIDTH -1:0]  data_out_real,
    output reg [DATA_WIDTH -1:0]  data_out_img,
    output reg                    valid_out,
    output reg                    done
);
    // State encoding//
     
       localparam  IDLE    = 3'b000,
                   READ    = 3'b001,
                   OPERATE = 3'b010,
                   DISPLAY = 3'b011,
                   DONE    = 3'b100;
  

    reg [10:0] count1;
   
    reg [DATA_WIDTH-1:0] Data_r[0:SEQ_LENGTH-1];
    reg [DATA_WIDTH-1:0] Data_i[0:SEQ_LENGTH-1];
    
    reg [DATA_WIDTH-1:0] Data_r_out[0:SEQ_LENGTH-1];
    reg [DATA_WIDTH-1:0] Data_i_out[0:SEQ_LENGTH-1];
    
    reg[2:0] state, next_state;
    reg [5:0] read_count, display_count;
    
    wire[SEQ_LENGTH*DATA_WIDTH-1:0] x_out,y_out;
    reg en;
    
    wire [SEQ_LENGTH*DATA_WIDTH-1:0] x_out1, y_out1;           // Original 128-bit wires
    reg [DATA_WIDTH-1:0] x_reg [SEQ_LENGTH-1:0];             // 8 x 16-bit registers for x_out
    reg [DATA_WIDTH-1:0] y_reg [SEQ_LENGTH-1:0];
    
    integer j;
    
    sixteen_pt_FFT  fft16 (Data_r[0],
                           Data_r[1],
                           Data_r[2],
                           Data_r[3],
                           Data_r[4],
                           Data_r[5],
                           Data_r[6],
                           Data_r[7],
                           Data_r[8],
                           Data_r[9],
                           Data_r[10],
                           Data_r[11],
                           Data_r[12],
                           Data_r[13],
                           Data_r[14],
                           Data_r[15],
                           Data_i[0],
                           Data_i[1],
                           Data_i[2],
                           Data_i[3],
                           Data_i[4],
                           Data_i[5],
                           Data_i[6],
                           Data_i[7],
                           Data_i[8],
                           Data_i[9],
                           Data_i[10],
                           Data_i[11],
                           Data_i[12],
                           Data_i[13],
                           Data_i[14],
                           Data_i[15],
                           x_out1,y_out1,clk,en);
                         
    
    

    
    genvar  i;
    for (i = 0; i < SEQ_LENGTH; i = i+1)
      begin
          always@(posedge clk)
            begin
              x_reg[i] <= x_out1[i*DATA_WIDTH +: DATA_WIDTH];
              y_reg[i] <= y_out1[i*DATA_WIDTH +: DATA_WIDTH];
            end
       end

    
    
    
    
  
    
    
    
   ////////////////////   FSM LOGIC SEQUENTIAL  ////////////////////////
    
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) 
         begin
            state <= IDLE;
            
            read_count <= 0;
            display_count <= 0;
            count1 <= 0;
            
            
            
            data_out_real <= 0;
            data_out_img <= 0;
            
            en <= 0;
            valid_out <= 0;
            done <= 0;
            
             for (j = 0; j < SEQ_LENGTH; j = j+1)
              begin
                  Data_r[j] <= 0;
                  Data_i[j] <= 0;
               end 

         end
         
        else
         begin
            state <= next_state;
            
            
            case (state)
                 IDLE: begin
                         done <= 0;  
                       end

                 READ: begin
                            Data_r[read_count] <= data_in_real;
                            Data_i[read_count] <= data_in_img;
                            read_count <= read_count + 1;
                       end

                 OPERATE: begin
                            en <= 1;
                            count1 <= count1 + 1;
                          end
  
                 DISPLAY: begin
                            data_out_real <= x_reg[display_count];
                            data_out_img  <= y_reg[display_count];
                            display_count <= display_count + 1;
                            valid_out <= 1;
                           end

                  DONE:  begin
                            read_count <= 0;
                            display_count <= 0;
                            count1 <= 0;
                            
                            data_out_real <= 0;
                            data_out_img <= 0;
                            
                            en <= 0;
                            valid_out <= 0;
                            done <= 1;
                         end

                 // default: ;
            
            endcase
         end
    end



    /////////////////////// FSM Next State Logic ////////////////////////
    
    always@(*) begin
       
        
        case (state)
        
            IDLE: begin
                    if (reset_n)
                      next_state = READ;
                    else 
                      next_state = IDLE;
                    
                  end

            READ: begin
                   if (valid_in && read_count < SEQ_LENGTH-1)
                     next_state = READ;
                   else 
                     next_state = OPERATE;
                     
                  end

            OPERATE: begin
                         // <<<  fft logic operation latency >>>
                      if (count1 == 48)                               
                         next_state = DISPLAY;
                      else
                        next_state = OPERATE;
                        
                     end
  
            DISPLAY: begin
                      
                      if (display_count < SEQ_LENGTH-1)
                        next_state = DISPLAY;
                      else
                        next_state = DONE;
                     end

            DONE:  begin
                      next_state = IDLE;
                   end

            default: next_state = IDLE;
        endcase
    end

  
endmodule