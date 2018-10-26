// Alessandra Fais, Orlando Leombruni
// RTT course - FPGA part
// MCSN - A.A. 2017/18

module fpga_interface(
	SW,
	HEX0,
	HEX2,
	HEX4,
	HEX5
);
	
	input [7:0] SW;
	
	output [6:0] HEX0;
	output [6:0] HEX2;
	output [6:0] HEX4;
	output [6:0] HEX5;
	
	wire [15:0] out;
	
	array_multiplier_gen arr(
		.a(SW[7:4]),
		.b(SW[3:0]),
		.p(out)
	);
	
	display_four disp1(
		.in(SW[7:4]),
		.out(HEX2)
	);
	
	display_four disp2(
		.in(SW[3:0]),
		.out(HEX0)
	);
	
	display_eight disp3(
		.in(out),
		.first_led(HEX4),
		.second_led(HEX5)
	);

endmodule