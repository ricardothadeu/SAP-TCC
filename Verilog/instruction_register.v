module instruction_register (
	input clock,
	input li,
	input [7:0] bus_in,
	output [3:0] bus_out,
	output [3:0] ir_to_controller
);
	reg [7:0] data;

	always @(posedge clock) begin
		if(li) data <= bus_in;
	end

	assign ir_to_controller = data[7:4];
	assign bus_out = data[3:0];

endmodule 
