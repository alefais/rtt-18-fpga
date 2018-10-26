// Alessandra Fais, Orlando Leombruni
// RTT course - FPGA part
// MCSN - A.A. 2017/18

module display_four(
    in,
    out
);

    input [3:0] in;
    output [6:0] out;
	
	reg [6:0] out;

	always @*
	begin
		case (in)
        4'b0000: // 0 
            out = 7'b1000000;
        4'b0001: // 1
            out = 7'b1111001;
        4'b0010: // 2
				out = 7'b0100100;
        4'b0011: // 3
				out = 7'b0110000;
        4'b0100: // 4
				out = 7'b0011001;
        4'b0101: // 5
				out = 7'b0010010;
        4'b0110: // 6
				out = 7'b0000010;
        4'b0111: // 7
            out = 7'b1111000;
        4'b1000: // 8
            out = 7'b0000000;
        4'b1001: // 9
            out = 7'b0010000;
        4'b1010: // 10 = A
            out = 7'b0001000;
        4'b1011: // 11 = b
            out = 7'b0000011;
        4'b1100: // 12 = C
				out = 7'b1000110;
        4'b1101: // 13 = d
				out = 7'b0100001;
        4'b1110: // 14 = E
				out = 7'b0000110;
        4'b1111: // 15 = F
				out = 7'b0001110;
    endcase;
	end

endmodule

module display_eight(
    in,
    first_led,
    second_led
);

    input [7:0]     in;
    output [6:0]    first_led;
    output [6:0]    second_led;

    wire [3:0] first_portion;
	assign first_portion = in[3:0];
	 
	wire [3:0] second_portion;
	assign second_portion = in[7:4];
	 
    display_four disp1(first_portion, first_led);
    display_four disp2(second_portion, second_led);
    
endmodule