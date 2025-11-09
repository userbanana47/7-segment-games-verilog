`timescale 1ns / 1ps

`include "button_debounce.v"

module button_debounce_tb;

    // Inputs
    reg clk;
    reg reset;
    reg btn;
    
    // Outputs
    wire debounce;

    // Instantiate the Unit Under Test (UUT)
    button_debounce uut (
        .clk(clk), 
        .reset(reset), 
        .btn(btn), 
        .debounce(debounce)
    );

    // Clock generation (50 MHz)
    always #10 clk = ~clk; // Toggle every 10ns, creating a 50MHz clock

    // Test procedure
    initial begin
    	$dumpfile ("button_debounce_tb.vcd"); 
        $dumpvars (0, button_debounce_tb);   
        // Initialize Inputs
        clk = 0;
        reset = 0;
        btn = 0;

        // Reset the system
        #100; 
        reset = 1;
        #100;
        reset = 0;
        #100;

        // Simulate button press and release
        // Assuming DEBOUNCE_TIME is long enough to filter out these bounces
        repeat (5) begin
            btn = 1;
            #20;    // Button press
            btn = 0;
            #20;    // Button release
        end

        // Simulate a long button press
        #100;
        btn = 1;
        #100000; // Hold button for a longer period
        btn = 0;
        #10000;

        // Finish simulation
        $finish;
    end
      
endmodule
