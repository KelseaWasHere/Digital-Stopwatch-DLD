//RCA Code (with HA) 
module HA(A, B, sum, carry);
  input A, B;
  output sum, carry;

  assign sum = A^B;
  assign carry = A&B;
endmodule 

module RCA(a, cin, sum, carry);
  input cin; 
  input [3:0] A; 
  output [3:0] sum;
  output carry;
  wire [2:0] g;

  HA h1(A[0], cin, sum[0], g[0])
  HA h2(A[1], g[0], sum[1], g[1]);
  HA h3(A[2], g[1], sum[2], g[2]);
  HA h4(A[3], g[2], sum[3], carry);
endmodule

//D Flip-Flop code
module DFFO_4(d, clk, reset, q);
  input d, clk, reset;
  output q;
  always @(posedge clk)
    begin
      if(reset == 1'b1)
        q <= 1'b0;
      else
        q <= d;
    end 
endmodule 

//T Flip-Flod code
module TFF0(clk, reset, t, q);
  input clk, reset, t;
  output q; 
  always @(posedge clk)
    begin 
      if(!rst)
        q <= 1'b0;
      else
        if (t) 
          q <= ~q;
      else 
        q <= q; 
    end 
endmodule 
  

//BCD_Display Code
module BCD_Display(A, B, C, D, a, b, c, d, e, f, g);
  input A, B, C, D;
  output a, b, c, d, e, f, g;

  assign a = (B&~D)|(~A&~B&~C&D);
  assign b = (B&~C&D)|(B&C&~D);
  assign c = (~B&C&~D);
  assign d = (B&~C&~D)|(B&C&D)|(~B&~C&D);
  assign e = D|(B&~C);
  assign f = (~B&C)|(C&D)|(~A&~B&D);
  assign g = (B&C&D)|(~A&~B&~C);
endmodule 

//Count 10 Code
module count10(clk, inc, reset, count, count_eq_9); 
  input clk, inc, reset; 
  output [3:0] count; 
  output count_eq_9; 
  wire rst1, rst2; 
  wire [3:0] rca; 

  assign rst1 = (inc & count_eq_9);
  assign rst2 = (rst1 | reset); 

  RCA r1(count, inc, rca);
  DFF0_4 dff(rca, clk, rst2, count); 
  assign count_eq_9 = (count==4'b1001) ? 1 : 0;
endmodule 
        
