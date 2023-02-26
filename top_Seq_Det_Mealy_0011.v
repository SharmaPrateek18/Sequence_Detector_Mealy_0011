`timescale 1ns / 1ps


module Frequency_Divider(clock_in,clock_out);  // Clock Divider module

input clock_in;                                // Clock input of 100MHz frequecy
output reg clock_out;                          // Clock output of low frequency (1 Hz)
reg [26:0]count;

initial 
begin
    clock_out=0;                               // Initializing clock = 0
end

always@(posedge clock_in)                      
begin
    count<=count+1;
    if(count==27'd50000000)
    begin
        clock_out=!clock_out;
        count<=0;
    end
end
       
endmodule

 


module top_Seq_Det_Mealy_0011(Clock, w, Resetn, z);     // Mealy state machine for detecting sequence 0011
 
input Clock, w, Resetn ;                          // w is the input sequence & Resetn stands for active low reset
output reg z ;                                    // z is the output
reg [1:0]y, Y;                                    // Y is the next state variable, y is the present state variable
parameter [1:0] A = 0, B = 1, C=2, D=3;           // Different States of Mealy state machine

Frequency_Divider clknew(Clock,clk1);             // Clock divider Module

always @(posedge clk1)
begin
    case (y)
        A: if (w==1)
                begin
                    Y = A; z = 0;
                end
            else
                begin
                    Y = B; z = 0;
                end

        B: if (w==1)
                begin
                    Y = A; z = 0;
                end
            else
                begin
                    Y = C; z = 0;
                end

        C: if (w==1)
                begin
                    Y = D; z = 0;
                end
            else
                begin
                    Y = A; z = 0;
                end

        D: if (w==1)
                begin
                    Y = A; z = 1;
                end
            else
                begin
                    Y = B; z = 0;
                end
    endcase
end

always @(posedge clk1 or negedge Resetn)
begin
    if (Resetn == 0)begin
        y <= A;
        z=0;
end

    else
        y <= Y;
    
end

endmodule
