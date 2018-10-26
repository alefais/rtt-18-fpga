// Alessandra Fais, Orlando Leombruni
// RTT course - FPGA part
// MCSN - A.A. 2017/18

module registered_multiplier (
	clk,
	rst,
	in_A,
	in_B,
	enable_A,
	enable_B,
	out_A,
	out_B,
	out_P
);
	input			clk;
	input			rst;
	input [7:0] in_A;
	input [7:0] in_B;
	input			enable_A;
	input			enable_B;
	
	output [15:0] out_P;
	output [7:0] out_A;
	output [7:0] out_B;
	
	wire [15:0] P;
	
	reg [7:0]  out_A = 8'b00000000;
	reg [7:0]  out_B = 8'b00000000;
	reg [15:0] out_P;
	
	always @ (posedge clk) begin
		if (rst) begin
			out_A <= 8'd0;
		end
		else if (enable_A) begin
			out_A <= in_A;
		end
	end
	
	always @ (posedge clk) begin
		if (rst) begin
			out_B <= 8'd0;
		end
		else if (enable_B) begin
			out_B <= in_B;
		end
	end
	
	n_bit_multiplier_gen nbm(
		.a(out_A),
		.b(out_B),
		.p(P)
	);
	
	always @ (posedge clk) begin
		if (rst) begin
			out_P <= 16'd0;
		end
		else begin
			out_P <= P;
		end
	end
	
endmodule