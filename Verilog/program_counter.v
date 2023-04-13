module program_counter (
	input clock,
	input cp,
	input ep,
	output [3:0] bus_out
);

	reg [3:0] data = 4'b0000;

	always @(posedge clock) begin
		if(cp)
			data = data + 4'b1;
	end

	assign bus_out = data;

endmodule 