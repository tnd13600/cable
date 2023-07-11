`timescale 1ns/1ps
module gear_timer
(
  //inputs
   clk
  ,resetn
  ,en_gear_timer
  //output
  ,gear_end
 );
  input clk;
  input resetn;
  input en_gear_timer;
  output gear_end;
  //16 seconds
  reg [3:0] cnt;
  always@(posedge clk or negedge resetn)
  begin
	if(!resetn)
	cnt <= 4'd0;
	else if(en_gear_timer)
	   cnt<= cnt + 1'b1;
	else if(cnt==4'd15)
	   cnt<= 1'b0;
  end
  
  assign gear_end = (cnt==4'd15);
 endmodule