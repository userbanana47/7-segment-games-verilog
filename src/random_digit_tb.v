`timescale 1ns/1ps

`include "random_digit.v"

module random_digit_tb;
    reg clk = 1'b0;
    reg reset = 1'b1;
    wire [3:0] rnd;

    // Instantiation
    random_digit uut (
        .clk(clk),
        .reset(reset),
        .rnd(rnd)
    );

    always #10 clk = ~clk;

    initial begin
    	$dumpfile("random_digit_tb.vcd");
    	$dumpvars;
    	
    	#50 reset = 1'b0;
    	
        #1000 $finish;
    end

    // output
    initial begin
        $monitor("Zeit = %0t, Zufallszahl = %d", $time, rnd);
    end
endmodule
