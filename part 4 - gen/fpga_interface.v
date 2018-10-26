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

	input [9:0] SW;
	input [1:0] KEY;
	
	output [7:0] LEDR;
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	output [6:0] HEX3;
	
	reg [7:0] in1;
	reg [7:0] in2;
	
	reg [7:0] LEDR;
	wire [7:0] out1;
	wire [7:0] out2;
	wire [15:0] out3;
	
	initial begin
		in1 <= 8'd0;
		in2 <= 8'd0;
	end
	
	registered_multiplier mul(
		.clk(KEY[1]),
		.rst(KEY[0]),
		.in_A(in1),
		.in_B(in2),
		.enable_A(SW[9]),
		.enable_B(SW[8]),
		.out_A(out1),
		.out_B(out2),
		.out_P(out3)
	);
	
	display_eight displ1(
		.in(out3[7:0]),
		.first_led(HEX0),
		.second_led(HEX1)
	);
	
	display_eight displ2(
		.in(out3[15:8]),
		.first_led(HEX2),
		.second_led(HEX3)
	);
	
	always @* begin
		if (SW[9]) begin
			in1 <= SW[7:0];
			LEDR <= out1;
		end
		else if (SW[8]) begin
			in2 <= SW[7:0];
			LEDR <= out2;
		end
	end
	
endmodule