`timescale 1ns/1ps
module line_timer
(
  //inputs
   clk
  ,resetn
  ,en_line_timer
  //output
  ,line_end
 );
  input clk;
  input resetn;
  input en_line_timer;
  output line_end;
  //64 seconds
  reg [5:0] cnt;
  always@(posedge clk or negedge resetn)
  begin
	if(!resetn)
	cnt <= 6'd0;
	else if(en_line_timer)
	   cnt<= cnt + 1'b1;
	else if(cnt==6'd63)
	   cnt<= 1'b0;
  end
  
  assign line_end = (cnt==6'd63);
 endmodule