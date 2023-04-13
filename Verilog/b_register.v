module b_register (
	input clock,
	input [7:0] bus_in,
	input lb,
	output [7:0] b_to_alu
);

	reg [7:0] data;

	always @(posedge clock) begin
		if(lb) data <= bus_in;
	end

	assign b_to_alu = data;

endmodule 