# Create a virtual clock with a T ns period where clk is initialized
create_clock -period 10.000 -name virtual -waveform {0.000 5.000} -add [get_ports clk]


# Set correct input delays (min should be <= max)
set_input_delay -clock virtual -min 1.6 [get_ports {data_in_real}]
set_input_delay -clock virtual -max 2 [get_ports {data_in_real}]

# Set correct input delays (min should be <= max)
set_input_delay -clock virtual -min 1.6 [get_ports {data_in_img}]
set_input_delay -clock virtual -max 2 [get_ports {data_in_img}]

# Set correct input delays (min should be <= max)
set_input_delay -clock virtual -min 1.6 [get_ports {valid_in}]
set_input_delay -clock virtual -max 2 [get_ports {valid_in}]


# Set correct output delays (min should be <= max)
set_output_delay -clock virtual -min 1.6 [get_ports {data_out_real}]
set_output_delay -clock virtual -max 2 [get_ports {data_out_real}]


# Set correct output delays (min should be <= max)
set_output_delay -clock virtual -min 1.6 [get_ports {data_out_img}]
set_output_delay -clock virtual -max 2 [get_ports {data_out_img}]



# Set correct output delays (min should be <= max)
set_output_delay -clock virtual -min 1.6 [get_ports {valid_out}]
set_output_delay -clock virtual -max 2 [get_ports {valid_out}]


# Set correct output delays (min should be <= max)
set_output_delay -clock virtual -min 1.6 [get_ports {done}]
set_output_delay -clock virtual -max 2 [get_ports {done}]