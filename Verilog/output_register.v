module output_register (
	input clock,
	input [7:0] bus_in,
	input lo,
	output [7:0] out_to_display
);
	reg [7:0] data;
always @(posedge clock) begin
	if(lo) data <= bus_in;
end

assign out_to_display = data;

endmodule 