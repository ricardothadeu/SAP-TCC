module alu (
	input clock,
	input su,
	input [7:0] A,
	input [7:0] B,
	output [7:0] bus_out
);

	assign bus_out = su ? A + (~B + 1) : A + B;

endmodule 