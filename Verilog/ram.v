module ram (
	input clock,
	input we,
	input ce,
	input run,
	input [3:0] address,
	input [7:0] prog_data,
	output [7:0] bus_out
);

	reg [7:0] memory [0:15];
	initial begin
		memory[0] = 8'b00001001;
		memory[1] = 8'b00011010;
		memory[2] = 8'b00011011;
		memory[3] = 8'b00011100;
		memory[4] = 8'b1110xxxx;
		memory[5] = 8'b1111xxxx;
		memory[6] = 8'b11111111;
		memory[7] = 8'b11111111;
		memory[8] = 8'b11111111;
		memory[9] = 8'b00010110;
		memory[10] = 8'b00001110;
		memory[11] = 8'b00010000;
		memory[12] = 8'b00001111;
		memory[13] = 8'b11111111;
		memory[14] = 8'b11111111;
		memory[15] = 8'b11111111;
	end

	always @(*) begin
		if(!run && we) memory[address] = prog_data;
	end

	assign bus_out = memory[address];

endmodule 