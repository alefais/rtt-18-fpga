// Alessandra Fais, Orlando Leombruni
// RTT course - FPGA part
// MCSN - A.A. 2017/18

module fpga_interface(
	SW,
	KEY,
	LEDR,
	HEX0,
	HEX1,
	HEX2,
	HEX3
);

	input [7:0]		SW;
	input [1:0]		KEY;

	output [9:0]		LEDR;
	output [6:0]		HEX0;
	output [6:0]		HEX1;
	output [6:0]		HEX2;
	output [6:0]		HEX3;

	wire [7:0] output1;
	wire [7:0] output2;

	accumulator acc(
		.clk(KEY[1]),
		.rst(KEY[0]),
		.in(SW),
		.s(output1),
		.a(output2),
		.sum_wire(LEDR[7:0]),
		.overflow(LEDR[9]),
		.carry(LEDR[8])
	);

	display_eight displ1(
		.in(output1),
		.first_led(HEX0),
		.second_led(HEX1)
	);

	display_eight displ2(
		.in(output2),
		.first_led(HEX2),
		.second_led(HEX3)
	);
	
endmodule