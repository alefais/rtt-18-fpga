// Alessandra Fais, Orlando Leombruni
// RTT course - FPGA part
// MCSN - A.A. 2017/18

module n_bit_multiplier (
	a,
	b,
	p
);

	input [7:0] 	a;
	input [7:0]		b;
	
	output [15:0] 	p;
	
	wire [15:0] first_addend;
	wire [15:0] second_addend;
	wire [15:0] third_addend;
	wire [15:0] fourth_addend;
	wire [15:0] fifth_addend;
	wire [15:0] sixth_addend;
	wire [15:0] seventh_addend;
	wire [15:0] eighth_addend;
	
	wire [15:0] first_l1;
	wire [15:0] second_l1;
	wire [15:0] third_l1;
	wire [15:0] fourth_l1;
	
	wire [15:0] first_l2;
	wire [15:0] second_l2;
	
	assign first_addend = {{8{1'b0}}, 
									(a[7] & b[0]), (a[6] & b[0]), (a[5] & b[0]), (a[4] & b[0]), 
									(a[3] & b[0]), (a[2] & b[0]), (a[1] & b[0]), (a[0] & b[0])};
	assign second_addend = {{7{1'b0}}, 
									(a[7] & b[1]), (a[6] & b[1]), (a[5] & b[1]), (a[4] & b[1]), 
									(a[3] & b[1]), (a[2] & b[1]), (a[1] & b[1]), (a[0] & b[1]), 
									1'b0};
	assign third_addend = {{6{1'b0}}, 
									(a[7] & b[2]), (a[6] & b[2]), (a[5] & b[2]), (a[4] & b[2]), 
									(a[3] & b[2]), (a[2] & b[2]), (a[1] & b[2]), (a[0] & b[2]), 
									{2{1'b0}}};
	assign fourth_addend = {{5{1'b0}}, 
									(a[7] & b[3]), (a[6] & b[3]), (a[5] & b[3]), (a[4] & b[3]), 
									(a[3] & b[3]), (a[2] & b[3]), (a[1] & b[3]), (a[0] & b[3]), 
									{3{1'b0}}};
	assign fifth_addend = {{4{1'b0}}, 
									(a[7] & b[4]), (a[6] & b[4]), (a[5] & b[4]), (a[4] & b[4]), 
									(a[3] & b[4]), (a[2] & b[4]), (a[1] & b[4]), (a[0] & b[4]), 
									{4{1'b0}}};
	assign sixth_addend = {{3{1'b0}}, 
									(a[7] & b[5]), (a[6] & b[5]), (a[5] & b[5]), (a[4] & b[5]), 
									(a[3] & b[5]), (a[2] & b[5]), (a[1] & b[5]), (a[0] & b[5]), 
									{5{1'b0}}};
	assign seventh_addend = {{2{1'b0}}, 
									(a[7] & b[6]), (a[6] & b[6]), (a[5] & b[6]), (a[4] & b[6]), 
									(a[3] & b[6]), (a[2] & b[6]), (a[1] & b[6]), (a[0] & b[6]), 
									{6{1'b0}}};
	assign eighth_addend = {1'b0, 
									(a[7] & b[7]), (a[6] & b[7]), (a[5] & b[7]), (a[4] & b[7]), 
									(a[3] & b[7]), (a[2] & b[7]), (a[1] & b[7]), (a[0] & b[7]), 
									{7{1'b0}}};
		
	assign first_l1 = first_addend + second_addend;
	assign second_l1 = third_addend + fourth_addend;
	assign third_l1 = fifth_addend + sixth_addend;
	assign fourth_l1 = seventh_addend + eighth_addend;
	
	assign first_l2 = first_l1 + second_l1;
	assign second_l2 = third_l1 + fourth_l1;
	
	assign p = first_l2 + second_l2;
	
endmodule