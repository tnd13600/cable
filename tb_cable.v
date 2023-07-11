`timescale 1ns/1ps
 module tb_cable;
 
  reg clk;
  reg resetn;
  reg detect;
  reg flag;
 
  wire open;
  wire en_sensor;
  wire en_acc;
  wire en_clamp;
 
  toplv_cable TOPLV_CABLE
  (
    .clk          (clk)
   ,.resetn       (resetn)
   ,.detect       (detect)
   ,.flag         (flag)
   ,.open         (open)
   ,.en_sensor    (en_sensor)
   ,.en_acc		  (en_acc)
   ,.en_clamp     (en_clamp)
  );
  initial begin
  clk = 0;
  forever #5 clk =~ clk;
  end
  
  initial begin
  resetn = 0;
  detect = 0;
  flag = 0;
  #20 resetn = 1;
  
  #30 flag = 1;
      detect = 1;
  #2000
      detect = 0;
  #100 $finish;
   
  end

 
endmodule