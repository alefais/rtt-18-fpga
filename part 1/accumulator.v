// Alessandra Fais, Orlando Leombruni
// RTT course - FPGA part
// MCSN - A.A. 2017/18

// Range of the sum:
// - largest positive number on 8 bits is 01111111 binary = +127 decimal
// - largest negative number on 8 bits is 10000000 binary = -128 decimal

module accumulator (clk,
					rst,
					in,
					s,
					a,
					sum_wire,
					overflow,
					carry
					);

	// inputs
	input 		clk;
	input 		rst;
	input [7:0] in;

	// outputs
	output [7:0] a;
	output [7:0] s;
	output 		 overflow;
	output 		 carry;
	output		 sum_wire;
	
	wire [7:0] sum_wire;
	wire	   carry_wire;

	reg [7:0] a;
	reg [7:0] s;
	reg 	  overflow; // contains the overflow into the sign bit
	reg 	  carry;
	reg [1:0] state;

	// states of the accumulator
	parameter go = 1'b0;
	parameter finish = 1'b1;

	// ---------------------- design implementation ------------------------------

	initial begin
		a <= 8'd0;
		s <= 8'd0;
	end

	assign {carry_wire, sum_wire} = s + a;
	
	always @(posedge clk or posedge rst) begin // active low reset
		if (rst) begin
			a <= 8'd0; // decimal zero value, equivalent to 8'b00000000
			s <= 8'd0;
			overflow <= 1'b0;
			carry <= 1'b0;
			state <= go;
		end
		else begin
			case (state)
				go:
				begin
					a <= in;
					carry <= carry_wire;
					s <= sum_wire;
					if (!(s == 8'd0)) begin
						if (a[7] == 1'b0 && s[7] == 1'b0 && sum_wire[7] == 1'b1) begin // sum of 2 positive numbers must be positive
							overflow <= 1'b1;
							state <= finish;
						end
						else begin
							if (a[7] == 1'b1 && s[7] == 1'b1 && sum_wire[7] == 1'b0) begin // sum of 2 negative numbers must be negative
								overflow <= 1'b1;
								state <= finish;
							end
							else begin
								overflow <= 1'b0;
								state <= go;
							end
						end
					end	
					else begin
						overflow <= 1'b0;
						state <= go;
					end
				end
			endcase
		end
	end

endmodule