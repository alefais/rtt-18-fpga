// Alessandra Fais, Orlando Leombruni
// RTT course - FPGA part
// MCSN - A.A. 2017/18

module full_adder (
	a,
	b,
	c_in,
	s,
	c_out);

	input wire a;
	input wire b;
	input wire c_in;
	
	output wire s;
	output wire c_out;
	
	wire partial = a ^ b;
	
	assign s = c_in ^ partial;
	
	assign c_out = (partial) ? c_in : b;

endmodule

module adder_8bit (
	a,
	b,
	c_in,
	s,
	c_out
);

	input [7:0] 	a;
	input [7:0]		b;
	input				c_in;
	
	output [7:0] 	s;
	output			c_out;
	
	wire [6:0]		carry;
	
	full_adder fa_1 ( 
		.a(a[0]), 
		.b(b[0]), 
		.c_in(c_in), 
		.s(s[0]), 
		.c_out(carry[0]) );
	
	full_adder fa_2 (
		.a(a[1]),
		.b(b[1]),
		.c_in(carry[0]),
		.s(s[1]),
		.c_out(carry[1]) );
	
	full_adder fa_3 (
		.a(a[2]),
		.b(b[2]),
		.c_in(carry[1]),
		.s(s[2]),
		.c_out(carry[2]) );
	
	full_adder fa_4 (
		.a(a[3]),
		.b(b[3]),
		.c_in(carry[2]),
		.s(s[3]),
		.c_out(carry[3]) );
	
	full_adder fa_5 (
		.a(a[4]),
		.b(b[4]),
		.c_in(carry[3]),
		.s(s[4]),
		.c_out(carry[4]) );
	
	full_adder fa_6 (
		.a(a[5]),
		.b(b[5]),
		.c_in(carry[4]),
		.s(s[5]),
		.c_out(carry[5]) );
	
	full_adder fa_7 (
		.a(a[6]),
		.b(b[6]),
		.c_in(carry[5]),
		.s(s[6]),
		.c_out(carry[6]) );
	
	full_adder fa_8 (
		.a(a[7]),
		.b(b[7]),
		.c_in(carry[6]),
		.s(s[7]),
		.c_out(c_out) );
	
endmodule

module n_bit_multiplier(
	a,
	b,
	p);
	
	input [7:0] a;
	input [7:0] b;
	
	output [15:0] p;
	
	wire [6:0] results1;
	wire [6:0] results2;
	wire [6:0] results3;
	wire [6:0] results4;
	wire [6:0] results5;
	wire [6:0] results6;
	
	wire [7:0] carry;
	
	assign p[0] = a[0] & b[0];
	
	adder_8bit row1(
		.a({1'b0, (a[7] & b[0]), (a[6] & b[0]), (a[5] & b[0]), 
			(a[4] & b[0]), (a[3] & b[0]), (a[2] & b[0]), (a[1] & b[0])}),
		.b({(a[7] & b[1]), (a[6] & b[1]), (a[5] & b[1]), (a[4] & b[1]),
			 (a[3] & b[1]), (a[2] & b[1]), (a[1] & b[1]), (a[0] & b[1])}),
		.c_in(1'b0),
		.s({results1, p[1]}),
		.c_out(carry[0]) );
	
	adder_8bit row2(
		.a({carry[0], results1}),
		.b({(a[7] & b[2]), (a[6] & b[2]), (a[5] & b[2]), (a[4] & b[2]),
			 (a[3] & b[2]), (a[2] & b[2]), (a[1] & b[2]), (a[0] & b[2])}),
		.c_in(1'b0),
		.s({results2, p[2]}),
		.c_out(carry[1]) );
	
	adder_8bit row3(
		.a({carry[1], results2}),
		.b({(a[7] & b[3]), (a[6] & b[3]), (a[5] & b[3]), (a[4] & b[3]),
			 (a[3] & b[3]), (a[2] & b[3]), (a[1] & b[3]), (a[0] & b[3])}),
		.c_in(1'b0),
		.s({results3, p[3]}),
		.c_out(carry[2]) );
	
	adder_8bit row4(
		.a({carry[2], results3}),
		.b({(a[7] & b[4]), (a[6] & b[4]), (a[5] & b[4]), (a[4] & b[4]),
			 (a[3] & b[4]), (a[2] & b[4]), (a[1] & b[4]), (a[0] & b[4])}),
		.c_in(1'b0),
		.s({results4, p[4]}),
		.c_out(carry[3]) );
	
	adder_8bit row5(
		.a({carry[3], results4}),
		.b({(a[7] & b[5]), (a[6] & b[5]), (a[5] & b[5]), (a[4] & b[5]),
			 (a[3] & b[5]), (a[2] & b[5]), (a[1] & b[5]), (a[0] & b[5])}),
		.c_in(1'b0),
		.s({results5, p[5]}),
		.c_out(carry[4]) );
		
	adder_8bit row6(
		.a({carry[4], results5}),
		.b({(a[7] & b[6]), (a[6] & b[6]), (a[5] & b[6]), (a[4] & b[6]),
			 (a[3] & b[6]), (a[2] & b[6]), (a[1] & b[6]), (a[0] & b[6])}),
		.c_in(1'b0),
		.s({results6, p[6]}),
		.c_out(carry[5]) );
	
	adder_8bit row7(
		.a({carry[5], results6}),
		.b({(a[7] & b[7]), (a[6] & b[7]), (a[5] & b[7]), (a[4] & b[7]),
			 (a[3] & b[7]), (a[2] & b[7]), (a[1] & b[7]), (a[0] & b[7])}),
		.c_in(1'b0),
		.s(p[14:7]),
		.c_out(p[15]) );

endmodule