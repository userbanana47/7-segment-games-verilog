// Copyright 2025 Michael Schurz
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE−2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//`default_nettype none
`timescale 1ns / 1ps

`include "tt_um_seven_segment_games.v"

module testbench ();

	// Inputs
	reg [7:0] ui_in;
	reg [7:0] uio_in;
	reg clk;
	reg rst_n;
	reg ena;

	// simluation signals
	reg sim_btn1;
	reg sim_btn2;
	reg sim_btn3;
	reg sim_btn4;
	reg sim_btn_switch;

	// Outputs
	wire [7:0] sevenseg_output;
	wire [7:0] uio_out;
	wire [7:0] uio_oe;

  // Replace tt_um_example with your module name:
  tt_um_seven_segment_games  user_project (
      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (sevenseg_output),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );
  
  // cLock generation
  always #50 clk = ~clk;
  
	initial begin
		$dumpfile ("testbench.vcd");
		$dumpvars (0, testbench);
		
		clk = 0;
		rst_n = 1;
		ena = 0;
		ui_in = 8'b0;
		uio_in = 8'b0;
		
		sim_btn1 = 0;
		sim_btn2 = 0;
		sim_btn3 = 0;
		sim_btn4 = 0;
		sim_btn_switch = 0;
		
		// reset
		#1000;
		rst_n = 0;
		#1000;
		rst_n = 1;
		#1000;
		
		// simulate game_counter
		repeat (3) begin
			sim_btn1 = 1;
			ui_in[0] = sim_btn1;
			#1000000;
			sim_btn1 = 0;
			ui_in[0] = sim_btn1;
			#100000;
		end
		repeat (2) begin
			sim_btn2 = 1;
			ui_in[1] = sim_btn2;
			#1000000;
			sim_btn2 = 0;
			ui_in[1] = sim_btn2;
			#100000;
		end
		
		#5000;
		// switch to game_dice
		sim_btn_switch = 1;
		ui_in[4] = sim_btn_switch;
		#1000000;
		sim_btn_switch = 0;
		ui_in[4] = sim_btn_switch;
		#10000;
		
		//simulate game_dice
		repeat (3) begin
			sim_btn1 = 1;
			ui_in[0] = sim_btn1;
			#1000000;
			sim_btn1 = 0;
			ui_in[0] = sim_btn1;
			#100000;
		end
		
		#5000;
		//switch to game_higher_lower
		sim_btn_switch = 1;
		ui_in[4] = sim_btn_switch;
		#1000000;
		sim_btn_switch = 0;
		ui_in[4] = sim_btn_switch;
		#100000;
		
		//simulate game_higher_lower
		repeat (5) begin
			sim_btn1 = 1;
			ui_in[0] = sim_btn1;
			#1000000;
			sim_btn1 = 0;
			ui_in[0] = sim_btn1;
			#100000;
		end
		sim_btn2 = 1;
		ui_in[1] = sim_btn2;
		#1000000;
		sim_btn2 = 0;
		ui_in[1] = sim_btn2;
		#100000;
		
		#5000;
		//switch to reaction
		sim_btn_switch = 1;
		ui_in[4] = sim_btn_switch;
		#100000;
		sim_btn_switch = 0;
		ui_in[4] = sim_btn_switch;
		#10000;
		
		//simulate game_reaction
		
		
		#1_000_000;
		$finish;
	end
endmodule
