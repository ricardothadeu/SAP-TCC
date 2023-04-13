module mar (
	input clock,
	input [3:0] bus_in,
	input run,
	input lm,
	input [3:0] prog_address,
	output [3:0] mar_to_ram
);
	reg [3:0] data;

	always @(posedge clock) begin
		if(lm) data <= bus_in;
	end

	assign mar_to_ram = run ? data : prog_address;

endmodule