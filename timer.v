`timescale 1ns/1ps
module timer
(
  //inputs
   clk
  ,resetn
  ,en_timer
  //output
  ,ready
 );
  input clk;
  input resetn;
  input en_timer;
  output ready;
  //8 seconds
  reg [2:0] cnt;
  always@(posedge clk or negedge resetn)
  begin
	if(!resetn)
	cnt <= 3'd0;
	else if(en_timer)
	   cnt<= cnt + 1'b1;
	else if(cnt==3'd7)
	   cnt<= 1'b0;
  end
  
  assign ready = (cnt==3'd7);
 endmodule