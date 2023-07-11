`timescale 1ns/1ps
 module toplv_cable
(
  //inputs
   clk
  ,resetn
  ,detect
  ,flag
  //outputs
  ,open
  ,en_sensor
  ,en_acc
  ,en_clamp
  //,index
 );
 
 input clk;
 input resetn;
 input detect;
 input flag;
 output open;
 output en_sensor;
 output en_acc;
 output en_clamp;

 wire ready;
 wire line_end;
 wire gear_end;
 wire en_line_timer;
 wire en_gear_timer;
 
 fsm FSM
 (  .clk           (clk)
   ,.resetn        (resetn)
   ,.detect        (detect)
   ,.flag	       (flag)
   ,.ready         (ready)
   ,.line_end      (line_end)
   ,.gear_end      (gear_end)
   ,.open	       (open)
   ,.en_sensor     (en_sensor)
   ,.en_acc        (en_acc)
   ,.en_clamp      (en_clamp)
   ,.en_line_timer (en_line_timer)
   ,.en_gear_timer (en_gear_timer)
 );
 assign en_timer = (detect & flag);
 timer TIMER
 (  .clk 		    (clk)
   ,.resetn         (resetn)
   ,.en_timer		(en_timer)
   ,.ready          (ready)
 );
  
   line_timer LINE_TIMER
 (  .clk 		    (clk)
   ,.resetn         (resetn)
   ,.en_line_timer	(en_line_timer)
   ,.line_end       (line_end)
 );
 
   gear_timer GEAR_TIMER
 (  .clk 		    (clk)
   ,.resetn         (resetn)
   ,.en_gear_timer	(en_gear_timer)
   ,.gear_end       (gear_end)
 );
 
endmodule