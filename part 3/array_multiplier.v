// Alessandra Fais, Orlando Leombruni
// RTT course - FPGA part
// MCSN - A.A. 2017/18

module full_adder (a,
				   b,
				   c_in,
				   s,
				   c_out
				   );

	// inputs
	input wire a;
	input wire b;
	input wire c_in;
	
	// outputs
	output wire s;
	output wire c_out;
	
	wire partial = a ^ b;
	
	assign s = c_in ^ partial;
	
	assign c_out = (partial) ? c_in : b;

endmodule

module array_multiplier (a,
						 b,
						 p
						 );

	// inputs
	input wire [3:0] a;
	input wire [3:0] b;
	
	// outputs
	output wire [8:0] p;
	
	wire [3:0] row1_carry;
	wire [3:0] row2_carry;
	wire [2:0] row3_carry;
	
	wire [2:0] row1_out;
	wire [2:0] row2_out;
	
	// ---------------------- design implementation ------------------------------

	// row 1

	assign p[0] = a[0] & b[0];
	
	full_adder fa_1_1 ( 
		.a(a[1] & b[0]), 
		.b(a[0] & b[1]), 
		.c_in(0), 
		.s(p[1]), 
		.c_out(row1_carry[0]) );
	
	full_adder fa_1_2 (
		.a(a[2] & b[0]),
		.b(a[1] & b[1]),
		.c_in(row1_carry[0]),
		.s(row1_out[0]),
		.c_out(row1_carry[1]) );
	
	full_adder fa_1_3 (
		.a(a[3] & b[0]),
		.b(a[2] & b[1]),
		.c_in(row1_carry[1]),
		.s(row1_out[1]),
		.c_out(row1_carry[2]) );
	
	full_adder fa_1_4 (
		.a(0),
		.b(a[3] & b[1]),
		.c_in(row1_carry[2]),
		.s(row1_out[2]),
		.c_out(row1_carry[3]) );
		
	// row 2
	
	full_adder fa_2_1 ( 
		.a(row1_out[0]), 
		.b(a[0] & b[2]), 
		.c_in(0), 
		.s(p[2]), 
		.c_out(row2_carry[0]) );
	
	full_adder fa_2_2 (
		.a(row1_out[1]),
		.b(a[1] & b[2]),
		.c_in(row2_carry[0]),
		.s(row2_out[0]),
		.c_out(row2_carry[1]) );
	
	full_adder fa_2_3 (
		.a(row1_out[2]),
		.b(a[2] & b[2]),
		.c_in(row2_carry[1]),
		.s(row2_out[1]),
		.c_out(row2_carry[2]) );
	
	full_adder fa_2_4 (
		.a(row1_carry[3]),
		.b(a[3] & b[2]),
		.c_in(row2_carry[2]),
		.s(row2_out[2]),
		.c_out(row2_carry[3]) );
	
	// row 3
	
	full_adder fa_3_1 ( 
		.a(row2_out[0]), 
		.b(a[0] & b[3]), 
		.c_in(0), 
		.s(p[3]), 
		.c_out(row3_carry[0]) );
	
	full_adder fa_3_2 (
		.a(row2_out[1]),
		.b(a[1] & b[3]),
		.c_in(row3_carry[0]),
		.s(p[4]),
		.c_out(row3_carry[1]) );
	
	full_adder fa_3_3 (
		.a(row2_out[2]),
		.b(a[2] & b[3]),
		.c_in(row3_carry[1]),
		.s(p[5]),
		.c_out(row3_carry[2]) );
	
	full_adder fa_3_4 (
		.a(row2_carry[3]),
		.b(a[3] & b[3]),
		.c_in(row3_carry[2]),
		.s(p[6]),
		.c_out(p[7]) );

endmodule