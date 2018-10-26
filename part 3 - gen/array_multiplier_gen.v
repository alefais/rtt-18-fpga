// Alessandra Fais, Orlando Leombruni
// RTT course - FPGA part
// MCSN - A.A. 2017/18

module array_multiplier_gen (a,
							 b,
							 p
							 );

	// inputs
	input [3:0] a;
	input [3:0] b;

	// outputs
	output [7:0] p;
	
	wire [7:0] temp_and0;
	wire [7:0] temp_and1;
	wire [7:0] temp_and2;
	wire [7:0] temp_and3;

	// ---------------------- design implementation ------------------------------

	// produce all the summands: evaluate the AND rows
	genvar i;
	generate
		for (i = 0; i < 8; i = i + 1) begin : generate_AND0
			if (i > 3) begin
				assign temp_and0[i] = 1'b0;
			end
			else begin
				assign temp_and0[i] = (a[i] & b[0]);
			end
		end
	endgenerate

	genvar j;
	generate
		for (j = 0; j < 8; j = j + 1) begin : generate_AND1
			if ((j < 1 ) || (j > 4)) begin
				assign temp_and1[j] = 1'b0;
			end
			else begin
				assign temp_and1[j] = (a[j - 1] & b[1]);
			end
		end
	endgenerate

	genvar k;
	generate
		for (k = 0; k < 8; k = k + 1) begin : generate_AND2
			if ((k < 2 ) || (k > 5)) begin
				assign temp_and2[k] = 1'b0;
			end
			else begin
				assign temp_and2[k] = (a[k - 2] & b[2]);
			end
		end
	endgenerate

	genvar l;
	generate
		for (l = 0; l < 8; l = l + 1) begin : generate_AND3
			if ((l < 3 ) || (l > 6)) begin
				assign temp_and3[l] = 1'b0;
			end
			else begin
				assign temp_and3[l] = (a[l - 3] & b[3]);
			end
		end
	endgenerate

	// compute the final product: sum all	
	assign p = temp_and0 + temp_and1 + temp_and2 + temp_and3;

endmodule