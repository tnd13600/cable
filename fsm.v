`timescale 1ns/1ps
module fsm
(
  //inputs
   clk
  ,resetn
  ,flag
  ,ready
  ,line_end
  ,gear_end
  ,detect
  
  //outputs
  ,open
  ,en_sensor
  ,en_acc
  ,en_clamp
  ,en_line_timer
  ,en_gear_timer
 );
 input clk;
 input resetn;
 input detect;
 input ready;
 input flag;
 input line_end;
 input gear_end;
 output reg open;
 output reg en_sensor;
 output reg en_acc;
 output reg en_clamp;
 output reg en_line_timer;
 output reg en_gear_timer;
 
 localparam IDLE = 2'b00;
 localparam TIMEOUT = 2'b01;
 localparam LINE = 2'b10;
 localparam GEAR = 2'b11;
 
 reg [1:0] current_state;
 reg [1:0] next_state;
 
 assign en_timer = (flag & detect);
  always@(posedge clk or negedge resetn)
  begin
	if(!resetn)
	  current_state <= IDLE;
	else
	  current_state <= next_state;
  end

  always@(*)
  begin
	case(current_state)
	  IDLE: begin
		if(en_timer)
		   next_state = TIMEOUT;
		else next_state = IDLE;
	  end
	  TIMEOUT: begin
		if(ready)
		   next_state = LINE;
		else next_state = TIMEOUT;
	  end  
	  LINE: begin
		if(line_end)
		   next_state = GEAR;
		else next_state = LINE;
	  end
	  GEAR: begin
		if(gear_end)
		   next_state = IDLE;
		else next_state = GEAR;
	  end
	  default: next_state = IDLE;
	 endcase
  end
  
  always@(*)
  begin
    case(current_state)
	  IDLE: begin 
	    open = 1'b1;
	    en_sensor = 1'b1;
	    en_clamp = 1'b0;
	    en_acc = 1'b0;
	    en_line_timer = 1'b0;
	    en_gear_timer = 1'b0;
	    end
	  TIMEOUT: begin
	    open = 1'b1;
	    en_sensor = 1'b1;
	    en_clamp = 1'b0;
	    en_acc = 1'b1;
	    en_line_timer = 1'b0;
	    en_gear_timer = 1'b0;	    
	    end
	  LINE: begin
	    open = 1'b0;
	    en_sensor =1'b0;
	    en_clamp = 1'b1;
	    en_acc = 1'b0;
	    en_line_timer = 1'b1;
	    en_gear_timer = 1'b0;
	    end
	  GEAR: begin
        open = 1'b1;
	    en_sensor =1'b0;
	    en_clamp = 1'b1;
	    en_acc = 1'b0;
	    en_line_timer = 1'b0;
	    en_gear_timer = 1'b1;
	    end      
	  default: begin
        open = 1'b0;
	    en_sensor =1'b0;
	    en_clamp = 1'b0;
	    en_acc = 1'b0;
	    en_line_timer = 1'b0;
	    en_gear_timer = 1'b0;
	    end  
    endcase
  end
 endmodule
