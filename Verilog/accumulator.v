module accumulator (
	input clock,
	input la,
	input [7:0] bus_in,
	output [7:0] bus_out,
	output [7:0] acc_to_alu
);

	reg [7:0] data;

	always @(posedge clock) begin
		if(la) data <= bus_in;
	end

	assign bus_out = data;
	assign acc_to_alu = data;

endmodule 